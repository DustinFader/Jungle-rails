/// <reference types="cypress" />

describe('Jungle app home page', () => {
  it('display the home page', () => {
    cy.visit('/');
  });

  it('click "Add to Cart" button and have the cart number go up', async () => {
    cy.get('article:nth-child(1) .btn').click({force: true});
    cy.get('.end-0 > .nav-link').should('contain', 1);
  });
});
