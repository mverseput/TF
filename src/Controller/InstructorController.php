<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use App\Entity\Lesson;
use App\Form\LessonType;
use Symfony\Component\HttpFoundation\Request;
use App\Repository\LessonRepository;



class InstructorController extends AbstractController
{
    #[Route('/instructor', name: 'app_instructor')]
    public function index(LessonRepository $lessonRepository): Response
    {
        $lessons = $this->getUser()->getLesson();

        return $this->render('instructor/instructor.html.twig', [
            'controller_name' => 'InstructorController',
            'lessons' => $lessons,
        ]);
    }

    //     #[Route('/instructor/create-lesson', name: 'app_create_lesson')]
    // public function createLesson(Request $request): Response
    // {
    //     $lesson = new Lesson();

    //     $form = $this->createForm(LessonType::class, $lesson);
    //     $form->handleRequest($request);

    //     if ($form->isSubmitted() && $form->isValid()) {
    //         dd($lesson);
    //         $entityManager = $this->getDoctrine()->getManager();
    //         $entityManager->persist($lesson);
    //         $entityManager->flush();

    //         $this->addFlash('success', 'Lesson created successfully.');

    //         return $this->redirectToRoute('app_instructor');
    //     }

    //     return $this->render('instructor/lesson.html.twig', [
    //         'form' => $form->createView(),
    //     ]);
    // }

    #[Route('/instructor/create-lesson', name: 'app_create_lesson')]
    public function createLesson(Request $request): Response
    {
        $lesson = new Lesson();
        $form = $this->createForm(LessonType::class, $lesson);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $instructor = $this->getUser();
            $lesson->setUser($instructor);
            // dd($lesson);

            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($lesson);
            $entityManager->flush();

            $this->addFlash('success', 'Lesson created successfully.');

            return $this->redirectToRoute('app_instructor');
        }

        return $this->render('instructor/lesson.html.twig', [
            'form' => $form->createView(),
        ]);
    }


    #[Route('/lesson/{id}/update', name: 'app_update_lesson')]
    public function updateLesson(Request $request, LessonRepository $lessonRepository, int $id): Response
    {
        $lesson = $lessonRepository->find($id); 
        if ($this->getUser() !== $lesson->getUser()) {
            $this->addFlash('error', 'You are not authorized to update this lesson.');
            return $this->redirectToRoute('app_instructor');
        }

        $form = $this->createForm(LessonType::class, $lesson);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->flush();

            $this->addFlash('success', 'Lesson updated successfully.');

            return $this->redirectToRoute('app_instructor');
        }

        return $this->render('instructor/update-lesson.html.twig', [
            'form' => $form->createView(),
        ]);
    }


}
