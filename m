Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC4E20AF80
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600258; cv=fail; b=pKQIOOIiCC5M8PRvE6HagYpNeLF86Yo0yIoKGTxSLosssdC9r30dJ9tgYb7VVaebAh8ISAHFsabX7/UA8GZSqgunx7c6YqZ/I9IEoi7A4lvNJ9Cqe7T5vr4S4RA85rKUoyL52DmoPWIzoJ2cfQ5YqrNUNp7dpd9SzAe7VZZ4tQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600258; c=relaxed/simple;
	bh=l7C6UpLbEJ5c7fqCuQDh5UI7lN/69XEP+JfMElIrCZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ivA4mXb7fGA//pH6ATahRheLdMtoZMNY2GT8Da3p0PQj/nzxHHxiGvxCTclphbnQU11MRgQut8fnlUZ8HhX8eWd4xR6p28KX4m+xFFPlfsbudBjaWlpkLUAN7LZlaI8o4hPi7zacEEMQHyuU1Xr7K6BhXpHTAisVZQHXCeY3Gw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m4oiPiz0; arc=fail smtp.client-ip=40.107.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m4oiPiz0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5xaqYmjdROKKKf63/jjsDfF49KyRmNLU3kLsmQ7bdgT9n8LEUoR8o9ZKZ7+iY1aAwSrB/97TbrEECXFnxyaLn8gsfnbtREGayYdzVi38zacAvLOVGhTXfEKdzIZfhXSxlO8sfrIkKh0FKKir1HC4M8sg+nYaZ5C1yEHuOCHOaeIDssLZx9Hht087KGOrjkew1dvC24EBjVxw0r0i7ExkcZPbd6xcAbUv39a/6NPyUiYkPqaqILEQXTWG7ccCjka1yJ8rpzmzlDyuBmIYq9Q/LwHPcu3cluDQOyF9fbxhB3bEqdB94BVLGA0KunBFpL3iON88TaPK9FlW073krK7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7C6UpLbEJ5c7fqCuQDh5UI7lN/69XEP+JfMElIrCZA=;
 b=UFnPXNolXqQTHy4QzTrdx34oM1blWWa/9I75BpXc2nkrLnQmJ5eSPwN0OrtnTfS6fr3HCHwZRUZ3G2wQswZKFzIvLZRzrZgOMhC+uKOsq+m8fv0g1FoJoEU/mmpOZY4b09YinCz2hE/PKcW75PIPTHh7Qe5liabMM5/0BMEqGqlhFwcCJsk6eC4e9oqjjymBvCNYaR/8/Jc4p95z9CN0L8IfltOxEwbHgz+KFwJxsBfqZkJdg6PYBadrmnjmeTXKsqFR2p4ksD/pRpkDSknEZ3Cp2ylFwSONo1dXZZLIEi1Ef6PyYYZNqYimwYFgYkyXompkrrhzeAVSaqOgjvW6lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7C6UpLbEJ5c7fqCuQDh5UI7lN/69XEP+JfMElIrCZA=;
 b=m4oiPiz01B6DsvTwq9Iz4ZdeMGahMYjRXL+GKzhat6jZCWFAGjurcv1nrzqmeZNfnPTPVhYtEq7GIbMv7mgtpVpB+uP39Qr/XGjWF7l5oeWRAxHWtP5FKPjUB1GbJG29aJJ6lIjfjziSkJaLCfqsNS+ajp2ux+W5pYIK+auXBdD2/ZCtcLHXzWcEyzzcv7yLPBfrDH/NpsKGyFQ7ta5qYH0kJG6EAG0/DawZ10IfQ6OnQhncvI6JEusEKubk7mh5FWS80QmSjVBNP1nWh/Y9cnVvyNbjTrvAF2P+Y84zDLnGPeMew6sCn9Ud70H0TaqGO3EtVE70XpAtvocK8qeXew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 16:30:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 16:30:53 +0000
Date: Mon, 3 Feb 2025 12:30:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, dave@stgolabs.net,
	shiju.jose@huawei.com
Subject: Re: [PATCH v2 08/16] cxl: Add FWCTL support to the CXL memdev driver
Message-ID: <20250203163052.GW5556@nvidia.com>
References: <20250201004459.466499-1-dave.jiang@intel.com>
 <20250201004459.466499-9-dave.jiang@intel.com>
 <20250203124232.00003dd2@huawei.com>
 <20250203142554.GV5556@nvidia.com>
 <2ab57ca5-40a9-471c-9b13-10b9b2bbc504@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ab57ca5-40a9-471c-9b13-10b9b2bbc504@intel.com>
X-ClientProxiedBy: BLAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:208:32d::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c1c809-dc6a-4128-8068-08dd447020cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oSg1iPY1WTuspIKxEVXPDOKECfFfxFObyOUMoB/+VPC7yVN7VPbZ/O9fEG+k?=
 =?us-ascii?Q?6EkHhCyKa4vus9RRWA7LbIV8oKPWXwPviuy40eQ5SzfuPC61lKH3juOwJBRy?=
 =?us-ascii?Q?r/Y6dfsDrzN6HWANtq/vOh8QW1k+/AnuPaSzfq80/yLy86BxKb9Cma9pg1xb?=
 =?us-ascii?Q?qVJhjIJj5z72x8b6YMDGG1MWQD/RDGDNsWgZyc8lTfbJtCHByweKZycYdmlF?=
 =?us-ascii?Q?4nJ6WBB8HeD4B6WEHTooXej7SfG+UdBAj0nQ5Y9u/ZPXGlO63IEGRa2SzamY?=
 =?us-ascii?Q?ybScUpKOMhfD1k6qXrAxSWJDqoj/KSTuus0dbsh2vSwkxH4ylQgiD8Hhp8l8?=
 =?us-ascii?Q?gEeSMhzWZ6eVQR7s0ZIztuLpKllVUPo03lfRoqzX9qIVdlhYJ2cspDgW8gSu?=
 =?us-ascii?Q?mTuxebGrUGtOKTGqoANHTxGj+L8k+NIbXDo7On+i3Sz7auPS1/WnwRZRPNi9?=
 =?us-ascii?Q?2zfYso7vOpHgf9X5ObQyxKk7yjd/wORAFU09qO48TyQ/SWX3RzrLmBiKnVOk?=
 =?us-ascii?Q?LYkkow1CkznXHv7MqDi4KhjF/5ej3kHOrhM6/F0NHFjglBPuHZvv5cQMXy3h?=
 =?us-ascii?Q?TK87rsM1XXQkaUjqdUfUPmY185bS3MmYlGHefFS7iElyGzw7a42FqRxof44W?=
 =?us-ascii?Q?XDQdp1i4M5BY3kpZ/4X3HwAAD6SQWR5AEEBToRgt40HEi5rxDExO3KTYkeWc?=
 =?us-ascii?Q?goNvjEfYTXHzBAfiu7HuKBTIfdznrG/MGKC7990JB1plXRPjbgAxlzFUKh99?=
 =?us-ascii?Q?2k6/Yj3rQMSh6H7q3d6aIDBhb8rv36twYOQtOMcia3/vWOKDFahPWEt4Wu0A?=
 =?us-ascii?Q?bkfEZM8wfCb7eDj/xl8pqJapFcsAGHtxxJxBG+7A+6lrfHHyc7Fe1oTWERvH?=
 =?us-ascii?Q?dK1f+3fsIgQO80BsS9qU0c1qX9hTrU2O4fbP/IiUHlGEN0GwuSYvvFfc3oht?=
 =?us-ascii?Q?CsC6euY1U47dJg1vcyZxCSgOaRg3DmjFy2QIkzuoyedQe+gX8f8cy6+qWKqA?=
 =?us-ascii?Q?f9aJoaV2F+fzTM+uuIyzgBcSRy8KLaXhullbTJLuHVXSr5Jv97HG1fIolk0y?=
 =?us-ascii?Q?qH3QAZfBkijqLa9L3Ki3VbpHV2D7zH7GjWgd5rd/ivpATmi0iGuDDKmBSaD5?=
 =?us-ascii?Q?OmP5r9gKX0HS+HOeR2MGK6b/0y6HW7b6bxK7Z6EIAS/hXWXX7/g0WbeN99ny?=
 =?us-ascii?Q?MXx352Kp2iiLJ2cI2gLmevogxvLP0Wm3sMfLoM7Pxn/Iqns7Lp2lV65xTdUR?=
 =?us-ascii?Q?eZq9g86vXndbuCIuBG6NQL8mI3cgVhego/zuertF/gwnDEfMGi9Ays5TNXAM?=
 =?us-ascii?Q?yGKbUESqNLzzIAYBiCii/cc314nxEWhf4dzAQAaeOzQM2UJTfn5sG+Z655Xh?=
 =?us-ascii?Q?Y3Z8RtbjUdrPB0h3rmmlL6Y7v2wY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tnIlMzTqj1WonPBBXfPeWU4O9/9VeL+YIK9rNzPJF35zfqHKTFn0trBB2joH?=
 =?us-ascii?Q?qO8MIMW/Hm4EqVvLzFs9U5VT4r/aB3KTnYS44KskRxfPws+eeEKow9UAyf2j?=
 =?us-ascii?Q?RfFR08itkzsPBjEupp8DMZHfwCNJpMANWAwuI8NZeHsS9XtAAEAU8GS6h+1Z?=
 =?us-ascii?Q?neZbctDXsWaeD8gHP0Ip1Wh52N/uQlvGIVlQOz8OJ+sVxR8W191yAHIgFL0X?=
 =?us-ascii?Q?pw/Jvd+ys8/NHhkocDoXc3PBcPu+i0t/0sk5WcgYU6dJlsgp+pDt1EdELQ1O?=
 =?us-ascii?Q?gsZ2aMjvye3XN24B5/098HKlvjVEp9vdkyBsSBnZg3L+z4eEVg+4bnvt/L3G?=
 =?us-ascii?Q?elitY/1BSFYbW80ts2h+RrNm6Y4mE8ADaPkxZCYDzxPR4rEL7nd71xUGWZzh?=
 =?us-ascii?Q?no9Inj1ZZBXEJh3sm6pZwAZtq7SC+3SjTlbr20kjnSJsjcfeNlUmAWPy5Wcf?=
 =?us-ascii?Q?OGuBDu85gZ6Y8J3uOD+HnIlYkSLWCVAk7rqh5tWprE/wdUIKQcdhbDyTJjyt?=
 =?us-ascii?Q?GiI4fAiYcFOp1dclbZTRDZ02u6a1SUSluKGsY/KNL3uyaqwP/qQyRhPyZyWj?=
 =?us-ascii?Q?3y+3DfwB6yU06mIdx4WPKITpFCB9zniss1N/a/E6Ab4IUiJwxCppjMwA7X7t?=
 =?us-ascii?Q?W9zM1KgGC+AyrGjgXBCN+xp8GWLmkAlct3+q6g4/sIcHZmiREGppsZoKIt5w?=
 =?us-ascii?Q?dYWIylQaK2EYXaOH1hkQ/FEIs/JXaGE5sY/whL96aBfiudhXVBZ9rWYURH48?=
 =?us-ascii?Q?HME2rJ1wUA1Ravweo3bOgIz7nsk1dIVTvyCyQ1kPYGN/i54NloS0ffzfKXLc?=
 =?us-ascii?Q?VvzAQKSpjOgHqVFq0uF82bCtvo78QZgK1GuCVb4F9qHBZ1eRuw6kemIaLEWQ?=
 =?us-ascii?Q?AODvVE11MNjO0IRCfCfq6b+3d/QWa2ZVkL9VD7k0+W9VOgZzBHF+c2xh3948?=
 =?us-ascii?Q?ba5cmoc3ox0/I/zfcyK0Xx1I4QjKeDnIv4rGZKHAXNpl7TZ5K1HvGVTEdx0k?=
 =?us-ascii?Q?gRPrBTh3NRE9pITF9iIHdNkt5AJxOa8o2sqTGtxP3unsvtCCl4YR2MDo0pVy?=
 =?us-ascii?Q?N8NTtj6qbvUO3mnMUGj7GNdWq/kFY3rHM2ZNrpLOK7/yr7d/tRq2gylD8rjW?=
 =?us-ascii?Q?Jil0KO0VkiODfvFRBJ9hXFH1Upy7CxD37BGHVlxI2WhFUAqgJagxLs7WuVnK?=
 =?us-ascii?Q?fEeukkh3ggksaehmqN3xUKOkkClaDdcEKEeMhqSJ1YwLT64CsVqX3DE7IQ0H?=
 =?us-ascii?Q?gatJ8beNTODo8QqpwIRTQOB973RUnBdEFnLKdrkI8ZQMGJ9XSUgN1UYBV/ol?=
 =?us-ascii?Q?tTF+WcRLxz5zIQHNZoolTKmZTIf7oyrMjCpiIQe48WtEeBf4Q31nAhvhLW0X?=
 =?us-ascii?Q?v+R9uXCWC68eqJkZJio3/fXektzuC7vMkJmKhYyccJ2qhbHYaw5XLl7qwcCd?=
 =?us-ascii?Q?t9TlUh3pqB7OzYNOfz5bb+czlnGC+D7sdGSPQ/sCNwTEMHmLgkRqb6QL7kbU?=
 =?us-ascii?Q?MkiGrPp88/uKJBG65KWHGezy5sPdGjCtZ/Sfr7PtHEiI96EVsu6FiiIc/YCR?=
 =?us-ascii?Q?25omZCJES0EyHFyKwfk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c1c809-dc6a-4128-8068-08dd447020cf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 16:30:53.5525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qNNaUUV3pUs1Qrw9znJTu7mXW0xmdnw9u+WYzS+8oDFNv1ztGNwX/qOWvyptdmz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493

On Mon, Feb 03, 2025 at 09:22:48AM -0700, Dave Jiang wrote:

> The intent is to allow the allocation function to be replaced with
> the FWCTL version when CONFIG_CXL_FWCTL is set. I'll think about how
> to do this differently. I was really trying to avoid doing #ifdef in
> the C file.

Use an #ifdef (maybe wrapped in an inline function or something), it
is much, much better

Jason
