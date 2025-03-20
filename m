Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B0F1F5F6
	for <linux-cxl@vger.kernel.org>; Thu, 20 Mar 2025 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513037; cv=fail; b=S6XmajgbZM0q5XABb6HtqygpgPG3/eSMHDVTF2hQuNDAr17r8zIigHaUC3q563gg1Mki3W0eVzIbCgcv7idzMRWw1WPldUhZ6ja3R8183XzmVeto13jEbk8B0sNSkBUgxFoU3vGUnWMTkHjxOvtj5dExIqCovF1cTCbwzjQou8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513037; c=relaxed/simple;
	bh=5PA6Lc+2WDvwXIlX0/CWMo9o2jnNfxSBeQYMvehiDFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F2JVmBwtMemm/ncKYcjuIFpY3/gRIAqQWWoONZkZzOz4jiwjLK+M1AW0t79+03qaHMWf2WZghV6TxDg5LTw5cMgSCFfNWw6VibzIuqDr3KQpJM7LY/xiFt/ba9JaakrMNJA9rb4r3sStQkaKq3s2hmN9HP0vyJUM5JXeqjnXiRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=at14c3GX; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="at14c3GX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVYUou5W7+QC9mRlXXyMQP4F71KO5ILIXqGSkAI2YlZattjPmSvw92Z1/2WCj2aiGFOxCECjr0lRzxAeKuoEJRNZgZXyi2PFa+vo3gUCB87wLySzEPRfuKCv3MNO2X7iWSvs3zrc5DK8+7w2FTk2p9K2doyQnpAYrnvncajbbCjM+cX+0Y2+Qjx/WjquO00MxqX7nDHiuD4TPs/0Lgx8Xp8I9MgH43tCRvE+ylEfMka44VCYSSrHEywNGbvQpOcUDOKFTyHe3V2WqEQL1F6R/LAwIVbLt7YWsSa+aB17NN96CMhIO9NEK4n4RDdm72JQP0QV2qvWTYFhOjEp46eTcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rrbn27kR1AutmRQGoi9JqV4RnzMYxIgyYNQ1tnvQhSs=;
 b=RR7S0JxYEjm/DaA9MGRxRE0Qjj98UWtXBHTbY5BOfEzwPz/fQwgK8FsIGE+s77hzQ+OPVelPZ0Kf5bnM47sp04PVkHNTtsl0ZQJHel0ZZWX4HENWsrlLOe9o1FOIwtt2Irk1zBFHJMM5hDisrVkcW1iYCZUcj+N3a3Z0Ni1usn5yvikkZGzvuDBijP3a7qkqsJvvMvnp8qwEgTohscegFWP/R+98fVLFlvBYIEJS/1SDRMEQjHtuQqgI1ulVKfGH66MCBom+2EXM7J9txo7nUN8QPXRQ5XEqLPLWzD1oRCi1qQ/BWEst9MBy5RiVxl29CllP2JlsE3pUDP9vJ0LaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrbn27kR1AutmRQGoi9JqV4RnzMYxIgyYNQ1tnvQhSs=;
 b=at14c3GXfYqPb4a1qWjNycqvdmaqqCok/06dfWG+tDUPkHjTSbOV+FUYd8BxA6mk6BTQgQCss9HfifznzuA0nCMJcaLQYsO7jagxNvCzTIEemKaqCqDpUO/SSYjvAU/+dXMqYQ4USiZFTlCY1/j4CI6JbE5131kM0rkwG0eqqAaKOFAZyxXcPXwUO/vuwHVVl/eRIX/gKcXgNDK3JYIWSsMayMVJqCtAG1w923ZTb0hffcO12daHDvyPgmVWD6zd8xNKQsfqQfNiNxsjOh9yUARDmOjnSqHI5lgp6/IyhzjiQYn4R59GN5puhMmoC0p59OvIxxKum+2mT2YiGkDLZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:23:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 23:23:51 +0000
Date: Thu, 20 Mar 2025 20:23:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, saeedm@nvidia.com,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v8 0/9] cxl: Add CXL feature commands support via fwctl
Message-ID: <20250320232350.GA229450@nvidia.com>
References: <20250307205648.1021626-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307205648.1021626-1-dave.jiang@intel.com>
X-ClientProxiedBy: BLAPR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:208:32f::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 03464eca-fceb-429a-b9b2-08dd68064671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QLR6kDhOaUzKvgzjSAY17wMCgJWljOvjYqM7jlXO3PPcABmyFHiMNzlYhbkR?=
 =?us-ascii?Q?qu9DihGQBu2KI1Goboqvi47q8vyI6Axd1oOnVjdEts53BZPtJcRLFLL1YTI2?=
 =?us-ascii?Q?PDyxseWFzSQEcOwGLvDRGT8Y54hxsQkzSQOR8jyg29/twbmeruF0rB0x8J56?=
 =?us-ascii?Q?Fyhs3WnYfcg1lIYV4yWREEG8dZRNsxLl89KTeNtMdew4eIMw3F9Wb4Nl2+HP?=
 =?us-ascii?Q?rD8TCfP7ycstva4vtxTvBYmT1IF17l+ACKHSEKYYsSYCdUfk30qXgu9lRjKm?=
 =?us-ascii?Q?qTryC04G730POi7ASlCTTa8epuOPq9hrN4bTRwzylRbq42ZmCCEY5q4QKEB7?=
 =?us-ascii?Q?DqfWG4hbkSFx5fZ5jz3bJfmMiA8Uq3w4JyLoQ+y+X7NMrf4n3jzl5ZMBgqQM?=
 =?us-ascii?Q?dYjJiDAGmOQkdd4imxAHhMvhp4/K5bCV9LcN4SZyKYA2hGJHsc3PhIj+34jS?=
 =?us-ascii?Q?W6ssg91rpPLZhHsZUXpisUMRee86n+BRJUQG4h97gmZUUzGpqCOpPddKQlNF?=
 =?us-ascii?Q?zt19Q0RY7xegMr+ffH4AkcRPW4JyvJVDtzutplvlPboBg+Chm/z12OROJlyA?=
 =?us-ascii?Q?ZMjNdwYH+RwV80NkDrTrV9B+bFr43I4hPofcBWVhr7xcBuvsKz4EAFRT/m2D?=
 =?us-ascii?Q?IeSm86UyStsVu38XpRq81Vgd4+xQvbK/HmnPMtdNcVq7IdfWbLBzcKAdAKPz?=
 =?us-ascii?Q?KAl2kkOZOv44TEkbVJpGtdAzdPP9Clba5FJXaxk7ACvrmUw8IK7ThZZgodLW?=
 =?us-ascii?Q?K0A5zUr4vp8rRZ6man0kQ3VCl1LCyVabIv1FAalpKGlOCN0C6g8iIljHyHi9?=
 =?us-ascii?Q?jZ4xJLkXB69zy3GC/IGycFFhi82zy4B09WuF5RJQTZQtbHDdZZQntxMiOoeM?=
 =?us-ascii?Q?RP+tr6oLxid+u2KYeyZhsRQszCDDzVXezxuvAGDqNfTkk4QPW3UPLJK7FW0v?=
 =?us-ascii?Q?0eOA/y65UQozeIA0hhKAOLojhHoyBADa1J65w3q75AC8L8EgArxK8B+eRKVt?=
 =?us-ascii?Q?yNrfnUyRZcN2ShK6evcfLNxH2DHr90vJqEIBbqnWPDnWUd2huyMaAVMW4/KF?=
 =?us-ascii?Q?T/jB1OA2kUImPIbGBQK7RnNDC2+VUYGITTEyy7GpdyAuNRKD7ZfOlVXysggl?=
 =?us-ascii?Q?7HiAnQ4G35e+KLRoXDm4QIn+WdJ6uvt6+fP+I3P7MJkgreMGd9M4SNK9DLeK?=
 =?us-ascii?Q?T5v1Awjr/mccrhFAexlabsV/c9z8kVMF7LaEwLDTItA0vXbgp8JrZYzroua7?=
 =?us-ascii?Q?J+WdnnxxrH8mMe3K/IgKbQeHbTdyaX9huDHD4uqSm32q2AwdKHWRlqgEzaTN?=
 =?us-ascii?Q?c3/sfsFTMRl3HtD+N9ThsUkxoWyDBGTHWUgL2meHYGqy4UqocaeYe3BR092x?=
 =?us-ascii?Q?IG4cDi89LIIMgvIzFNW8OoMnwQRF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gKyaQfL2lHKzAfK+LfP+CFUHGoP739e37KtoJ9GC23peYGKuFOzhC+PqAfzo?=
 =?us-ascii?Q?h5PZHne1I7XPOEXAW6cA0RV2uMXhSUdjlAFMGNtE+lZpbnBhkIURLNZjsujg?=
 =?us-ascii?Q?2r238MXWj5HN+a1xgAlHiHAYEaoyDG1GZliV9sF5QFW3tYFNQrAJOqQAzjpM?=
 =?us-ascii?Q?BwTyOUxGthuYIw0wU8Frd3TXzaYbw9NOkwPPoTPu8SRHCicg2A0Z4ew8fb6w?=
 =?us-ascii?Q?6wMrrrCT7D6kS0RL4yjAZXqFVvq8CMnv8dg4kPYnVOxWWt12mx3ZN4BnL0Zf?=
 =?us-ascii?Q?HifSy5ynosVDO2ehJ4AFg+7YPs/H7D5WZsrvDobAPqASUudDmyh4ZHleU5Cf?=
 =?us-ascii?Q?RTIuL5IVxjWIS9gMd5cJWLp2weGrj+OJ6EpTFPBvTAx9/YObqtuPPTyctYZS?=
 =?us-ascii?Q?zB2gyD8md9gpAPhMH2LIXVVFXSuxX//6DYztDz+8t1Sv+pyMKdvfrqGgDftO?=
 =?us-ascii?Q?PP1l8qvFmdWkzrcZuyPZyQCDj92/ZTMDJ42Z1sRcysTSb2sqVtcp0M8N+Q1s?=
 =?us-ascii?Q?GgvQUoUqmg2PPtZ1ozmXdQu33nIMnD+A6XipE0w8d3iNgvyriEeXnQW+llDv?=
 =?us-ascii?Q?b5tLf/36KZNOe4mjeMwwucNkdmB7ws3eNjzejzfauT4NodhSfKO70WkJaLOX?=
 =?us-ascii?Q?mBmshHhXYSc0TmA53UjuasB2T3eFEYlskIv39Jtawm/R3wBOMpX/6RwnDiRF?=
 =?us-ascii?Q?2WZlp91V3NU/Z61lFG6+SDF49ExZ45HmBq1KUa4mfUl4ZwrLm4/dh7qS47nY?=
 =?us-ascii?Q?1DtYxvEMrJwceWoXjMmRT8nYxGP8woO0Y4PZ+Oue1s4WUDB2va7YICRw9ir0?=
 =?us-ascii?Q?mb/BW++RCFofnUuUJpskVtz0WtvevaPUMkEfrUpGmrekqaF56ltfz6gl/9bV?=
 =?us-ascii?Q?ZywNWUKGHw6+pyJfmV0oSRWt6RFkfFcMcmGpUmhuJRDjiIt0HOmfqlJdMmdv?=
 =?us-ascii?Q?JBCqyYAzw1JPkO91MoKEz+FnbQe7UJwbq87FZI5CUZ1pOV7wNmCI7wpGCHKf?=
 =?us-ascii?Q?jnRYOIOCwnW7LNxQiCOgxL6rhU+lx/1f6NtSU2nAOz6uYGI3HZAnFLipP2dE?=
 =?us-ascii?Q?KEO8MaWOT1KEsv4M791QCuYNmjg6JMI8TwnzboBoJanFp+Of6EQkF4UtFwkQ?=
 =?us-ascii?Q?Lo8iYwqxkvwpgBTs1jXo9lwgO9QPIwyX6eEFlNSHudaW8+Un6fsK4rxT0vbh?=
 =?us-ascii?Q?T4/1681sgX5lseTAREex0BxSETaLpmQfZyJMZFNcgcOAaB9U4TVlVsbaBpYV?=
 =?us-ascii?Q?D5mwRyVjyHZQ0gz79wQACLiBuh7O+VEk0FGJEu2PIy4PrHrNn83mmGhUgwdE?=
 =?us-ascii?Q?obOZuwclDQaP93Lq4cxuvqaGbLlR89QkF9sFkAXUzb/GQNiw4b0e81Gu5hOD?=
 =?us-ascii?Q?VyHltnz4CB4NsYka2qG+zMNYqy4bWbEJzVDdKfRGVFDSzINxMC2nLgoNefqn?=
 =?us-ascii?Q?tVLtqoxjBsw4hrsUIr14Y+vI/Mwu1H/u8nWCzNxdoOewCnLZEN9Wes35bwIr?=
 =?us-ascii?Q?Ct4IZFN/5Ql2XUJdwquBPo1badMn961Dc7k9/fWlt3ka68H++giuo8IljjS0?=
 =?us-ascii?Q?/YudqqHCrxzgOAsfBG8PkwYWiWIVoqmDHcy6Ux+l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03464eca-fceb-429a-b9b2-08dd68064671
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:23:51.9105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ps0kC78ZhYcE2H5zrDZCfQzG7MGMIIDrWDJHljops4reZm9UP0M588pwuw/VDEW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

On Fri, Mar 07, 2025 at 01:55:30PM -0700, Dave Jiang wrote:
> Hi Jason,
> This series is the remaining patches for cxl fwctl from your [1] branch with fixed
> up kdoc issues.
> 
> [1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=hmm
> 
> Dave Jiang (9):
>       cxl: Add FWCTL support to CXL
>       cxl: Move cxl feature command structs to user header
>       cxl: Add support for fwctl RPC command to enable CXL feature commands
>       cxl: Add support to handle user feature commands for get feature
>       cxl: Add support to handle user feature commands for set feature
>       cxl/test: Add Get Feature support to cxl_test
>       cxl/test: Add Set Feature support to cxl_test
>       fwctl/cxl: Add documentation to FWCTL CXL
>       cxl: Fixup kdoc issues for include/cxl/features.h

Applied along with the shared branch at commit a8b773f24203 ("cxl:
Setup exclusive CXL features that are reserved for the kernel"). It
has also been in linux-next for two weeks now..

Thanks,
Jason
