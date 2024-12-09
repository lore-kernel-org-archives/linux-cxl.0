Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB2F39ACC
	for <linux-cxl@vger.kernel.org>; Mon,  9 Dec 2024 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751173; cv=fail; b=ZDs5HBTY7OIN93eR7SlokekrML48wnf/90mZtNrZ6IFcpyvIAXiz23FClcaNqTM774Fb4jrXZX9n1yOlDXQSWdfY3Yum3D38ZBTsnHPEgpqsJ7GEEeDNebtPVwJ7wMEvtKj32iU6/Ft6dmOISYSPg0N2AFaQl6QA1uyVbrTI+BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751173; c=relaxed/simple;
	bh=jQDuTnM0BNq720SACc2l5icRy1OV78v2weESZPT++LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ht4RbGmXzBYQ8eTcpED1heRFzaDvSZPw7Hnb4fjsOG0GR+ahNlqAjngDQhmu/5l7kJvo7tOLTCmJKHfcoVlwZ93OI+x6spqPr5aKDudpGaU33RN5eQAklRae9PkpfAoBGKqo4m+ghnKdNCPnecUo279u1QhoO6SRWjRE3dBv1wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KQ2AoV0+; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KQ2AoV0+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVjyLVXLyC3f9xHCtMynLo5BR5HOzY4hvCfbg2zLAQ9ymkOnXDpIM3za01lYIU7tP80zfeRnHEZxvi1vm6bmnPV6z0jkVoMqpaw5TwkvMd3KsaDvP1aeaYRTztoKh5OW3isOd7bIB6mYu+ltOXDOTMV5Au6hyaLJ3IMaOxkAbDbYVdWl4kcAewXYVlXdLjMVW277j6lW549mxa6rH86IvhSNYj2mdUrGkIH+aP/X9tJosktBfihtZk4qSX5Qhq1IKiQuSC7Vtw4H5Y8HqxPndLlg4Pz4T/6lYasOeU7+kDWJhpvEv1J7moVGkyNd0KfTJNU+nzypuaqpTVaXDU4UZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qloP2doMoQo09juWPnDF5tHop82ZWpi/WHvjPUtRD6M=;
 b=GsEKiRXU1fnqiz0ItwuaHweQGeyeJXPsNdeLUb87rPftftTE+TbvWzNlU6tpXg0+mSZ6HjUzcqZZbu6gqF42TI/SZxnxsio+M9adTNTAai8hmLj2wr6lXpxiFWgBX0Qpe3Aw6udPGSY2RYa5pUe21nkzAEXyoWru2yrTmPNgmb/WnO96WQnUFTfDdLdFmgUFc5Pyc9Fau0YM3D7PU1gx/LkF8R/Ed6BZvBpcodvyuuTH7nik66/Su44+ZmYfwYOdoYhe2eJV617Jo60HcbWdBQjQpDflqgoZPN2z/oe5xqUkKhKG6QLofYXNiMqBt1KJpsvqbtF+/m/1435WMLxlsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qloP2doMoQo09juWPnDF5tHop82ZWpi/WHvjPUtRD6M=;
 b=KQ2AoV0+LMACcC66AVuuouFOsOMpGZ2aI1Ogc88ic888ioBhvvnmqUrbMWWA8NCVmE6t7EFt2MDYritKzwzTO3cuSBIldzgyLrDW0I6kqn4jDLt8+3w43TrjtlHvCN6NTWcqRIVawDRZSViJ3Cuqr6rLCxLLMXYCmW4S8Rz8174JLMyFUM/PCf+yMEeN/nV1tCWi7ZIgVMZfiWyTEhLsBe763Is0gTPZZRqrfyDyMpAUD8JkOGojyQ1hpNpr6idb0HHI2FolSF4JS4vyJcvRlO0cqdzuIPIqUEj5sMXW2C2jySYZZFWyRbzK4fd52EBki7rM50/P85guIqpXGSjxzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 13:32:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 13:32:43 +0000
Date: Mon, 9 Dec 2024 09:32:42 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [RFC PATCH v2 11/20] fwctl: FWCTL_HW_INFO to return hardware
 information
Message-ID: <20241209133242.GB2347147@nvidia.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-12-dave.jiang@intel.com>
 <67528c573b189_25073294db@dwillia2-xfh.jf.intel.com.notmuch>
 <49ec1992-8b45-4281-aabb-781e1e8ec1dd@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49ec1992-8b45-4281-aabb-781e1e8ec1dd@intel.com>
X-ClientProxiedBy: BN0PR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:408:e5::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 5502107b-f86e-46ae-55f8-08dd1855f5cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tQAUkYddGfARpr4QjpbtrihRsx8PtMMOfsrjB8V9swTlKXY8j1aLJxCjSKBv?=
 =?us-ascii?Q?Dcuytg9miElp6oyI++wlwTE5Xki8DgqZd+poXnmiN5r1RPLv/ABMfQcI+gva?=
 =?us-ascii?Q?8Vi2cV6J62ier1cszm3mV/3bBRlU5zyHSUMGS6vC7OLXr52u7mwWyzRMwXHf?=
 =?us-ascii?Q?GcOFmZUl9jQUw3/KFL8qu39LbBCbp21yzaRhs9Hwnu3FkJlu7rBHDENjlG+c?=
 =?us-ascii?Q?58GM7FgpIw4f1SqLRaOdeqy3vEDrLYjxLlxWIzSZKeGCpf/ybEnBELVDDTbm?=
 =?us-ascii?Q?yI5vjGRWjQx6b1eR1xp4aszUo2MDlCv6EhHOjeASMA5kq9l5sJDcJNFyYjoE?=
 =?us-ascii?Q?xvMCtHKhbT8H6Iv0Oj7b4ZcEXprN/UXHWhxGCAbby0mshpA8dyGCpywcE+YY?=
 =?us-ascii?Q?TMi7DonKBQVptPPd5pDHefu8Vf3TfvvQjTMdGxY/murFMGsf9h9o8a1iVxr0?=
 =?us-ascii?Q?hYn4GRwXhgh/aEttKoAcrmn0EJwtOWtqxeOGKw20/u092TQm/T3mIgy+uet1?=
 =?us-ascii?Q?EWsQA1UPsabgMQo0fXyCHnbsAo9CzvfzPyQ63dWoxCJjnWncvdKUD9gp2ffN?=
 =?us-ascii?Q?Sna6RdfYfj2JWpWXjOZcZ5Mcmx4bv/iDz2EZ6Q1xuu3NWojTxmPNNGPj/oE0?=
 =?us-ascii?Q?XJHHDaPyQc/IDfMRyNVw7Iol/y51sLcOKi3b3/aw6SU4Vc9IyXNhrZIdNkPu?=
 =?us-ascii?Q?9I/qMfqBMD3RzZbsH3cKREYhv0xoArIs21doHZ/7zZk0RQocX0YA4ovTbd9b?=
 =?us-ascii?Q?yI3groWvVf5DYs/dAwKqglfC05K5tG8cM6HFVJPS3suLGasahowEgNR6sEAi?=
 =?us-ascii?Q?c260TKW1Ff1B28FTz+YV/AHTHrj0DWAy+vIMOK3vKr6SSlGa1EPY1RVNGqBS?=
 =?us-ascii?Q?4AvJLGUx9A5gbO51swZg1qFoCjeSonaY++WbSTsxFk1OvBydLF7b8oGaDVjU?=
 =?us-ascii?Q?jyNEJXtGrJtOVCaZzOUAg+VjXUN54mS/jrnfnqH5I2pai0neGmvwstIqia3Y?=
 =?us-ascii?Q?dPkbxW2APeovJ1UNYdrFaVtT0w2HGeUIO+JVkMU7pZxtCkd01gVRjwCyLVOX?=
 =?us-ascii?Q?CW4ZrNg35ioCLORcToHaF6GLL83IyR5yjPNaHZbs7oMbD6Ozk8rNyueAjb98?=
 =?us-ascii?Q?kbmGEuHJNP/XzBSTRNweey4lQZGleUyqAIQzElldsJb4MVHDvBhLesemvtwH?=
 =?us-ascii?Q?tiWlRwDEz0adJXU8hta20rO2aKmLJh13sgtVTdSYzYOcr2zOsXx/TzIA71hi?=
 =?us-ascii?Q?ZzmHwWPNS4R8+QzWYCXFwm+gyWA4jP9fCcQFMnViJuP2eBEau/ykuFf0vHv9?=
 =?us-ascii?Q?SrTAYhMiyjk/xPAnJalMBEfP3+bEmL5rKarYFDr33bkc9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YP0VqlgmrdqexKqqochTPBX4sbg+6zfAs7laZgo2wshWWLMnNu7F/ZynAvwA?=
 =?us-ascii?Q?5PfqW8HkhVDsLIeAjd9ZDtkd7yXj1sTEIPhAnqDT7aNM1+1BYglaQeGwUzO2?=
 =?us-ascii?Q?k0Xo3ykNC5GrtvvYHvYkjG0TPP2GaRzz8Ogt/xTGRLVAirXfcR2JoemrvKlI?=
 =?us-ascii?Q?NOpEgmjXBepcYW6rwOZ50deHeJhNwl2pMP3J/kvumBW6OHn/1l0ZhNnByLp2?=
 =?us-ascii?Q?XrLlLxR9+9xX73HDKwpfoza/1VjJ1b6FC5lj7cQ/My2Vv5CV54U67/XANTQE?=
 =?us-ascii?Q?47NtkI2O1hrU3R+c895Tmrq5qc1b+FwZiUxN6xOcaHkAHnL/enrCU1ePiwhD?=
 =?us-ascii?Q?tlSxuUUGjL6X6jUlGvheE5SS4uZ+R5j8OZbiNMIw6Wcwu6uyZr7VDcVQ3Q72?=
 =?us-ascii?Q?fi+LksKGwy2p13LMhjkgEEnIZ6OJRxrIHi9J8PZMububBAhgZLFLhbK5YTg4?=
 =?us-ascii?Q?nfTSPUcxU5VH64izKf3jyb6hjDmb2KK4qHy2p/DGB/StS2T0nOsGgKxOSTQg?=
 =?us-ascii?Q?UnMVBQHxhaglxiCU/MUYthUpGIYjBvk9qwMOpoen33g74mlwvDTbPBabLoWs?=
 =?us-ascii?Q?sKEgGZZVf4yM4YeadfffVHxsPnwDT2wEZjL0z9UAvj+1MA4AFVvnLwDteezf?=
 =?us-ascii?Q?z4b3WcR11M4JFWTw0RoefLa6404MctYXzQq6rtd4CxGmeu62QhWvdSa0itL1?=
 =?us-ascii?Q?fXCoZwgSUNIwDRUjRhlmUJ9ITeBNZe9kM0EZ0swuwUgUS9cJxHhPvSanLtqL?=
 =?us-ascii?Q?esoC2K6aIHEh/Uw3U48Slx69zM5r0V2z7jysS5WV/ClrNyIp8E521RXv26Ie?=
 =?us-ascii?Q?2dDk8K0AVLdF15gn8nLxAOKqrKGH3VouZIH1t56iLFXT/GZ4JZNrYK6eeXVX?=
 =?us-ascii?Q?DRTSSdvwJXClGWxpWyBW9L8DDgvyi4jEHXJdaYon17vLKnwrkEjR73sIxaYd?=
 =?us-ascii?Q?P7Mz3cluH3HqOznOFwTzpXq8u5KYHgDZAbWlbhRruHyFZ2mxODYRc47Qqifk?=
 =?us-ascii?Q?eKJXrGuhw+2a8t1Xxt0R9BVkMPVa3lsjX8R5zqIYcRvSpnO8Ipc/82OzIo08?=
 =?us-ascii?Q?00FgNJv2w+yH0kWI/4cQoJk9teyyDbdq0ijOhflt+9agI+YwPUJ7OeW0E+U0?=
 =?us-ascii?Q?gGNt9dwpgQDQ2ni1fQndPwZkxsLjkIhQAASu/TENyD9Gsh6LaoMzMM6NI2lD?=
 =?us-ascii?Q?zlYQRUhnWFqNIo3jQc61mY95LBoP4qLhhnK1tPb6vZ3sOw0HS5papokrOGIT?=
 =?us-ascii?Q?eYvjMj+NU7PLPsnNRmeMJmYz+914nEQm8Wc9jwP4G9IJu1ufD1UCQ8p9TcMA?=
 =?us-ascii?Q?Yd53ExK7Y6lN7qbJHWX8WqV0QTM+43MK7EkhEzDUr6xsUvmhC4+xUHOwssYO?=
 =?us-ascii?Q?FIdLAEuMSgyzC4ZJXiesRRy76XkDD1q+4i4ZPdMDlYnFMP4O41lhp8ooxhYo?=
 =?us-ascii?Q?mhnrSRbrhO+Se3lUy2NxduwIJYKrma1DMmYQ84YsQH2Dzs7qvNTkdtwow0hY?=
 =?us-ascii?Q?T3YgVHGj9Or4d2TOnQCxnd1BMF+k/n/EaKsItGA9U4kaK6e/XYvGiRqHuqv/?=
 =?us-ascii?Q?9cHwXFRFmFsWLnfxfNXDIcjq0uF6afSX3FY1nLpe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5502107b-f86e-46ae-55f8-08dd1855f5cf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 13:32:43.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCgArBHRbstMUxbHNBjQv2vsZD5Qz886TiNCfW5nDHV719/LHoClDL52g1QYitDl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419

On Fri, Dec 06, 2024 at 11:39:03AM -0700, Dave Jiang wrote:
> 
> 
> On 12/5/24 10:32 PM, Dan Williams wrote:
> > Dave Jiang wrote:
> >> Add an optional ioctl FWCTL_HW_INFO to pass command specific information
> >> to user space. An array of 'struct fwctl_command_info' will be returned
> >> from the ioctl. These commands are send to the driver via FWCTL_RPC call.
> >> The command info struct contains the command id, the related hardware
> >> opcode, input and output size for the command, and the effects the command
> >> has if it's a write command.
> > 
> > Maybe this made more immediate sense to Jason, but I do not see why CXL
> > needs a FWCTL_CMD_HWINFO when FWCTL_CMD_RPC can just convey the GET
> > SUPPORTED FEATURES payload?
> 
> That is because I wrote the code with intention of supporting the
> existing chardev commands in addition to features. If we are only
> supporting feature commands fwctl, then we can drop this and make
> things simpler.

If that is what this series is doing then lets drop it, if you need it
later it is easy to add

Jason
