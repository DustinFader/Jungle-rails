describe('product details', () => {
  it('display the home page', () => {
    cy.visit('/');
  });

  it('There is products on the page', () => {
    cy.get(".products article").should("be.visible");
  });

  it('There is 2 products on the page', () => {
    cy.get(".products article").should("have.length", 2);
  });

  it('click on product article to enter the detail page of the product', () => {
    cy.get('article:nth-child(1) img').click();
    cy.get('.main-img').should("be.visible");
  });
});
