<?php

namespace App\Controller;

use App\Entity\Lesson;
use App\Entity\Registration;
use App\Form\VisitorType;
use App\Repository\LessonRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;


class CustomerController extends AbstractController
{
    #[Route('/customer-profile', name: 'app_customer_profile')]
    public function userProfile(Request $request): Response
    {
        $user = $this->getUser();

        $form = $this->createForm(VisitorType::class, $user);
        $form->remove('email');
        $form->remove('birthdate');
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->flush();

            $this->addFlash('success', 'Profile updated successfully!.');

            return $this->redirectToRoute('app_customer_profile');
        }

        return $this->render('customer/profile.html.twig', [
            'form' => $form->createView(),
        ]);
    }

    // ...

    /**
     * @Route("/logout", name="logout")
     */
    public function logout(AuthenticationUtils $authenticationUtils): Response
    {
        // Logout action implementation

        throw new \Exception('This method should not be reached.');
    }


    #[Route('/member/lessons', name: 'app_member_lessons')]
    public function lessons(LessonRepository $lessonRepository): Response
    {
        $lessons = $lessonRepository->findAll();

        return $this->render('customer/lessons.html.twig', [
            'lessons' => $lessons,
        ]);
    }



    #[Route('/lesson/{id}/join', name: 'app_join_lesson')]
    public function joinLesson(LessonRepository $lessonRepository,int $id): Response
    {
        $lesson=$lessonRepository->find($id);
        $user = $this->getUser();

        if (!$user) {
            return $this->redirectToRoute('app_login');

            $this->addFlash('error', 'You must be logged in to join the lesson.');
            return $this->redirectToRoute('app_member_lessons');
        }

        if (!$lesson) {
            $this->addFlash('error', 'Lesson not found.');
            return $this->redirectToRoute('app_member_lessons');
        }

        $registration = new Registration();
        $registration->setUser($user);
        $registration->setLesson($lesson);

        $entityManager = $this->getDoctrine()->getManager();
        $entityManager->persist($registration);
        $entityManager->flush();

        $this->addFlash('success', 'You have successfully joined the lesson.');

        return $this->redirectToRoute('app_member_lessons');
    }


    #[Route('/lesson/{id}/leave', name: 'app_member_leave_lesson')]
    public function leaveLesson(int $id): Response
    {
        $lesson = $this->getDoctrine()->getRepository(Lesson::class)->find($id);
    
        if (!$lesson) {
            $this->addFlash('error', 'Lesson not found.');
            return $this->redirectToRoute('app_member_lessons');
        }
    
        $user = $this->getUser();
        $registration = $lesson->getRegistration()->filter(function (Registration $registration) use ($user) {
            return $registration->getUser() === $user;
        })->first();
    
        if (!$registration) {
            $this->addFlash('error', 'You have not joined this lesson.');
            return $this->redirectToRoute('app_member_lessons');
        }
    
        $lesson->removeRegistration($registration);
    
        $entityManager = $this->getDoctrine()->getManager();
        $entityManager->persist($lesson);
        $entityManager->flush();
    
        $this->addFlash('success', 'You have left the lesson.');
    
        return $this->redirectToRoute('app_member_lessons');
    }
    
}
