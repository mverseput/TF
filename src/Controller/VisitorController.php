<?php

namespace App\Controller;

use App\Form\VisitorType;
use App\Repository\TrainingRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Entity\Lesson;
use App\Entity\User;
use App\Entity\Visitor;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;



class VisitorController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    public function home(): Response
    {
        return $this->render('visitor/index.html.twig', [
            'controller_name' => 'VisitorController',
        ]);
    }


    #[Route('/trainingen', name: 'training')]
    public function showTrainingen(TrainingRepository $trainingRepository): Response
    {
        $training = $trainingRepository->findAll();
        return $this->render('visitor/trainingen.html.twig', [
            'trainingen' => $training
        ]);
    }





















    #[Route('/contact', name: 'app_contact')]
    public function contact(): Response
    {
        return $this->render('visitor/contact.html.twig', [
            'controller_name' => 'ContactController',
        ]);
    }


    #[Route('/register', name: 'app_register', methods: ['GET', 'POST'])]
    public function register(Request $request, UserPasswordHasherInterface $passwordHasher): Response
    {
        $visitor = new User(); // Instantiate the Visitor entity class

        $visitor->setRoles(["ROLE_CUSTOMER"]);

        $form = $this->createForm(VisitorType::class, $visitor); // Pass the Visitor entity instance

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $hashedPassword = $passwordHasher->hashPassword(
                $visitor,
                $form->get('plain_password')->getData()
            );
            $visitor->setPassword($hashedPassword);

            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($visitor);
            $entityManager->flush();

            return $this->redirectToRoute('app_home');
        }

        return $this->renderForm('visitor/register.html.twig', [
            'form' => $form,
        ]);
    }


    #[Route('/login', name: 'app_login', methods: ['GET', 'POST'])]
    public function login(Request $request, AuthenticationUtils $authenticationUtils): Response
    {
        $error = $authenticationUtils->getLastAuthenticationError();

        $lastUsername = $authenticationUtils->getLastUsername();
        // dd($lastUsername);

        return $this->render('visitor/login.html.twig', [
            'last_username' => $lastUsername,
            'error' => $error,
        ]);
    }

    #[Route('/member-trainingen', name: 'app_member_trainingen', methods: ['GET', 'POST'])]
    public function trainingen(Request $request, AuthenticationUtils $authenticationUtils): Response
    {
        
        return $this->render('visitor/trainin.html.twig', [
            
        ]);
    }

}
