Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9C19DF62
	for <linux-cxl@vger.kernel.org>; Wed, 20 Aug 2025 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697909; cv=fail; b=InldpO2DCa9JWg3wxRKrFRIwja9Hp2cDNVe7i3Amhlq4vpuxC/d54xCMOGmTh9UiD9zWSehp2PTOHzPM4eDNKukYE2HYFsxrpPf0z/Al6sMZyd8cXxGTgpVBt5QrvnuDEYDi9qNUqdEi6T2VSJwNdOh9Xl8jdi+cE4Aj8LRVaqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697909; c=relaxed/simple;
	bh=UfXdtDHVjPZ3gqHnOCtAdlcMJLVIFd8RU9wvUXhm85I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L0aBYup2hntGJFq024U/W0LNyJfBtiDwvzDqOcK4FDp80Rz2sCAeum6zSzLOOtc2avef/OCjTK6c1KY6Ak1PZAIJpg3XoiyczJvCHhF5pTyc9+9riRfbTNlH43S46yk+zqLihoFJPDL7Ly3nJrUsBz9DlrGT0jmYsT0uHed7NEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3BVYhl+E; arc=fail smtp.client-ip=40.107.102.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3BVYhl+E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1Zw7NpuIqlNaKxTKLJ0UrKZ0qtTW6IeqzEl7DYKSPFdgG+kht+WbdbdY19qefX67bgIdYbBXIQaDY1IvCuwdQISx5Kil4Davpwhg7xMh8+W09iFcOm0jbXMjO5Rc2VAycXFWo9dzkP+1Kr6QmTSrycFsfKRo8ZTn9yuY7mA4TpUg5XwMeEt6IjY+vU1b4pF9425i0CuHPWGBE+GAdDDaAi5+L2glAlhBr2OZIiPjpyf8A/ZcVUqFSW6TcUYzN/OUtJ3fBGnqZZNTMdcmiQKxHhBC6OOkKzpCJGxHdzJFfLNWwp7F2UK1PmkuQsOfQL3GJybRARCS6/jA+O5DMgGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs5Of5Vf5+RMj2f/CrWWrGXMYGXarD3f2D5t0rbPzpk=;
 b=F1KAzlXhY1LSD+W+EmWjMoofwn5Euws1G8bmCRnjTRkH4bNrAwAndBhqmyPGtGvMDml+c8sybY62BXIqWsH3+5MfIbqJBAjB+to21GFOtkHsPQCSMvUFky3ifcgXOJmerYA079bC0Mns/FIGlj6TFMiL+wknFoPEaPeO5nt3FdvVcTGHejHWgiyhgBZylaKL0ydK8pnSECnPZW4LI47V5mTDNBLNlYGqvODFFvjlhPJDbqZabdWMNuGf9H335RqQyNelC2EOIzftLQu2R730fVd45BaZ0CFgPcfDPywdFNH2iIe5Ejb3lkcj08c0zbP18p3fwWVpPEjVQDJPeZ0GrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs5Of5Vf5+RMj2f/CrWWrGXMYGXarD3f2D5t0rbPzpk=;
 b=3BVYhl+ETKeXXhPtk9qUei6xFumcYIhpmcQHCILYUgRHnZz3C5U0vKzDvcyKDSMI1KBb4dNzBmua+n9lZWq/PtHAX0Rmo1Zmp+4j/x/Gv7Rh5IIL4Euky+QdGu6CYHw0zcFaMfpHek7k5WSLRv4dRD7K9hkoqZCClYxDxJusOVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM4PR12MB6229.namprd12.prod.outlook.com (2603:10b6:8:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 13:51:43 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9009.017; Wed, 20 Aug 2025
 13:51:43 +0000
Date: Wed, 20 Aug 2025 15:51:37 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v8 01/11] cxl: Add helper to detect top of CXL device
 topology
Message-ID: <aKXS6ZPwybJyStZw@rric.localdomain>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
 <20250814222151.3520500-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814222151.3520500-2-dave.jiang@intel.com>
X-ClientProxiedBy: FR4P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::11) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM4PR12MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3f01f3-3a9c-4947-06cf-08dddff0b204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i2c0voweJt7Du6iUOIJ4Yy5OX6mniwTqEqcS6FpNR1fiYX4kHz019uwhpTEI?=
 =?us-ascii?Q?JKA259wivmI40k4r86HD/HlC4h32SMawdXN4ntL/vml4eQ8ic8bD81aRZHIN?=
 =?us-ascii?Q?gMa2Hb6LgAx6z6+puJvvIBrL9gFc4GSUYyY+RHgiyLTsXhO2btkedaVTwL3T?=
 =?us-ascii?Q?YFoD8YBaQ+lFcdukvHXKhNEl6yStY/lw9GR7OQnyGsY+JlX+uQ7v7yg2GMnD?=
 =?us-ascii?Q?QTc40MOOM82PX/wk43lDDCiJEkrIBV21Ydh3Q6+00CJuharkhXrXGBv892Bz?=
 =?us-ascii?Q?e+fyHuiDuHbDuUNrsSxwTJs15vTpMFWE86u3mJFQOe1AfUY/k1jtLQ6MDabN?=
 =?us-ascii?Q?MUgdylLngliwuZYItsW71lIffOFn7CUY8s9kSCnP29KbjVUhloZssjV5Qa4m?=
 =?us-ascii?Q?b0IZt5V0s4DA5wxFnzeE/i3I79Kz3Y3PqFSFSBATJ2Li1tjbayB+ubF4HcSN?=
 =?us-ascii?Q?jPhXH+chCgQjCnxArN9+pji+roQJ5AYxZnXHOidIh/bm0S7mp6reXfFbYG51?=
 =?us-ascii?Q?1jbU/p9utWkYVfNUy2NKqqv7Apaf2t/7AWswtdpb5qx+WcsJvbKcbG4ShZlS?=
 =?us-ascii?Q?DOBGNc0PdB2sf/XSMKzWQU3RzRP03/xBW64+CmTwf2HM70CFE9bUfQ11PHVF?=
 =?us-ascii?Q?Ik4dkzB/9AJYDfowfhx/nw/rUx1da3AL8FJ9prs8gi7Yw1eDiWVpTJmlt+TR?=
 =?us-ascii?Q?9GSS0O0//AA+bI7upaGTOfxUVBSXni0yNq9Ksarz4V36do5dwYtynhqCaypQ?=
 =?us-ascii?Q?44L48s4qFe37UXrNsh3t7WATzd8aY1JjpW9pS4IW4B44MiQ+g7SIusMsN811?=
 =?us-ascii?Q?Z98GqsYd7govbmBzzepTmupzK6jTvD00AgEwpYKW/hh4y24GbTKyMHscorvL?=
 =?us-ascii?Q?lbCgoeXm7TnmkUTXFEtHv2GIVg9PA5TqpV6rsISHwv7MB5UlB98TQwdRKAfU?=
 =?us-ascii?Q?RKnLxIupx7WqXhq4GrX61YXjwh7aUm/U1dt1pZyhuGEoy/DU2yvYQO/NegDA?=
 =?us-ascii?Q?OZeJCCaVl2I7eAJVdpLWv7A3zFGBRh7Bw5W777Wm1xowBT0xkV51rdm5bnQt?=
 =?us-ascii?Q?QlxBWDmgi0jXV4ZUlR9ZG6bxNesKY9OvbTAbN5VFSrn1poCtX9a5sg4kbkr9?=
 =?us-ascii?Q?oMyv/Btk6E5DFIt/ToytPTfd7wlrAxHujgVhzPGiB8BBVzLTbHvOrSYt1nE5?=
 =?us-ascii?Q?iqioGpCkn26kFH73seMnJ1WNwikbbkoEjHhxd6TAB4+vknfji5rIzzIDiF1E?=
 =?us-ascii?Q?W5Sg2QUc3ldarlU/DYAhpscOMdF8Tjt8RJCg5BP5GuG8hyGggdeXi1a3pUiN?=
 =?us-ascii?Q?VaWZ2ckFIG89Gh/109D70YksFhW/CN0o+aZuaTXWnNMvuWiLYxCuGo82HXot?=
 =?us-ascii?Q?7O/SekrLN/t4YeG1N3E7DTZ4ep/pIMLVL7eNFA9ThO8HSYorZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FhDe6FBfo6XDjobiroQLmcOHcTVOpmZmDb+1MjhWvrSIZKmaLhaYIg50xVJT?=
 =?us-ascii?Q?UCg2l5IJT7Spt5HVoUMLidkEj00SwRBm9X9nAe4DfwwrcY3nn6ouj4Vt0LPl?=
 =?us-ascii?Q?Ae5BBpr1xbWYEhXrYi3W/VRxhz7UgzYQUdzAPCbHUEwkAE0J7bmwjle/q3BL?=
 =?us-ascii?Q?+6VmRTYA3VJC78xUt6EneOIKyZSiWWbzpyDNpgbqsGd0z18/nGOoPJZGj5Sf?=
 =?us-ascii?Q?b7sTH5HHiOfa+Rejb6dxbVQysFx/rZvn9xZS7+05zMqPiW4tWSARfEJnTuLn?=
 =?us-ascii?Q?ll8FNOPLrMAa0hE2CmcSGJPf9ikBk8J1YV6TY3n82WdInj5O+GjdXSKnXZv/?=
 =?us-ascii?Q?q86B3dbafFuqJYCEfKn9coehR/NrlK4NzxqeOkj0MZ25ISTN1YTgIEgvusig?=
 =?us-ascii?Q?9HCc1wxGzy4EfbRXQ4kxSy1N2Gf4+cdXbnDslowLsDeOCh6gR8zXUnBWp7xg?=
 =?us-ascii?Q?7uLrF/mqt4Rb+kz/7JU45kHHE+ZgSSol9ZCQhCmz2EAzHmndUjZe/xBlAQmC?=
 =?us-ascii?Q?/raRXdaJqld67WiGIIeluIh3OVscXmlMuDBtbzXqqWOiAzt6C5wt6GRRVH3C?=
 =?us-ascii?Q?4sPfzKysEnkoPWTuedIHZJsCtzgwKRPHZU6N2EzXx36qufijB6Xy5l8bmmrm?=
 =?us-ascii?Q?BfGMu6/Xib3pkwedE2qHjKmiuUaDjGt2tMcfcQ8d71iz/gxn4ckPkxe/9KWD?=
 =?us-ascii?Q?FUXxJ4EOaBYuwMWm+4ZxETw0ElftcTLjJuI3D/rNHbj2Ws4agZrGioMuZ5NS?=
 =?us-ascii?Q?YU1BIHSlca1c9TM3iqVVLZUXQBBxqkEa3byKrez664KYkbxLoYPWSmqnFk1f?=
 =?us-ascii?Q?e4tCW/+iOqFzJSMJJeAH2HRQC8lpE2KPbylnnnnrg66GK1oQJzi4o4zm4U5o?=
 =?us-ascii?Q?RiR/kojqvRfh3U2gc7WvR6X9a/hLjjWA/FdA7EOvbd0TsB7k9KrJW0dokQlY?=
 =?us-ascii?Q?cfKmJQV2XoiPoiUR5pP+0XRziA689uUiz5YE3ZPWBNmG2EUuV47NnNjgZaVW?=
 =?us-ascii?Q?PtA8TJ2bHlEAGCbGQoEu8EEvSgUoZBaTmtSA2CoGHrII6vGtjjVzF1GSsVE1?=
 =?us-ascii?Q?xtYMf8CI9jAvjQ+s6NtyhS/p9TkIk1quU2R8BkW9maYGrhDigks7+pZZSjJ3?=
 =?us-ascii?Q?wKmZiI7SZgcsXKU7DsgthxB/Hn44sixJneO0NXY/Ag1BtPiyTt/Mft9fPo1O?=
 =?us-ascii?Q?QxuXj9hPycrcOa3un0sXSNPKtgBKZJrLHm7MB+uLcUG3vDry6ZR1y5r0qFxs?=
 =?us-ascii?Q?EMFtnlVX5NvTpi97aavq0s93ZdouJIjeprrhv2Q3JvYorrq16PaTqAhf3VZR?=
 =?us-ascii?Q?xYcOqgNCnUL20V67M2i7xLyqqzzfNkpEcW6yfHVpMNweRNifZp9uUbVm8+tr?=
 =?us-ascii?Q?n89wVAEMwykgzrlfn/5lzTeSvuE1H7w2Qcr5yMB+i8o4XTP22D/iNtocEV5X?=
 =?us-ascii?Q?b5d1N+qvB36U6oZ7jKoJ4oR9rwN+fAzkWpQW3QM0T17OVqOFrWkb0WanaHiM?=
 =?us-ascii?Q?iHd0hAAtM6GuSye0PbrLB3jvKlvoHilqTmu+XXaoc1wwRLROG905XDWUG7X0?=
 =?us-ascii?Q?YGsevU0AKpJTmOSoADsVgNYPj5OG8mRuuT+303Bw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3f01f3-3a9c-4947-06cf-08dddff0b204
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:51:43.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4LU76E2ltmNQzO8PiX6+Xl1c+RemCYHlEKTPRh8AjFBgLpyWKnNKlTc4w3sLPt15YFzteqTnyJ4Eraf42ojkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6229

On 14.08.25 15:21:41, Dave Jiang wrote:
> Add a helper to replace the open code detection of CXL device hierarchy
> root, or the host bridge. The helper will be used for delayed downstream
> port (dport) creation.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Robert Richter <rrichter@amd.com>
