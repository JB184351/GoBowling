//
//  ViewController.m
//  ObjCTableView
//
//  Created by Justin Bengtson on 8/8/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

#import "ViewController.h"
#import "Course.h"

@interface ViewController ()

// Properties declasred in here are part of the class
@property (strong, nonatomic) NSMutableArray<Course *> * courses;

@end

@implementation ViewController

// String declaration in Objective C
NSString * cellId = @"cellId";

// Array of courses


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupCourses];
}

- (void)setupCourses {
    self.courses = NSMutableArray.new;
    
    // Allocated a new object
    Course * course = Course.new;
    course.name = @"Instagram Firebase";
    course.numberOfLessons = @(49);
    [self.courses addObject:course];
    
    // All Strings need @ symbol
    self.navigationItem.title = @"Courses";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellId];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Specifying types for variables in Objective C and Pointers for referring to classes
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    Course * course = self.courses[indexPath.row];
    
    cell.textLabel.text = course.name;
    return cell;
}


@end
