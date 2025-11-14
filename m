Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA30730F52B;
	Fri, 14 Nov 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137260; cv=fail; b=ioV5SDpbERflP5iJYTPFi7OB6e09JMGRNEtVOunT7rAW5OY7QWGGBgyc/kmAKiTpCs8jpxWAwfsl6tR1b0vSnwD7XqAtleEMIYrv19LomcQzwnQVb29IufNIhNrMSJ0/SNkhMalzxgJR/8OMEB9ATHwofKGSxNYxLc/kyebM0qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137260; c=relaxed/simple;
	bh=BtV/iOvlyY4olkRoe/q4wB3Vr2U9ChCRPNE5xMTsQ90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZMAi+w0nskpKrKDVjGnWQbjFRdDZ8BvRVWSzH5UNd7KFRjwrhfQ17fuIFRlM7nf1fqsv5popKK9+0JsRoIBLCZo+AKfE/K2RVoo253m+4RVCoLwsT/sx5aGtBkSLkKVqoGpcYMjUFTWdPr6efe2esb5boa64dr00ASRnr6xiktY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ATXy6Zrg; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ATXy6Zrg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nk53RFi69wAdmby2lLGBFT8EFGQEZMGrse6/wx9YoIlIKZez0iF8upZYY/TnxtkPrDzc0E6HD5rkXgCuJhrXB4XAMpORyMBTPuxOuTMnJm/pd49KAH4CcLHn167X+gGeilQyLtkqpUxI0gFLjyToQ9bKWLoKUCkBO+4upz+Pp8PwACUaQRXaHY05q8KjYMbVqv4NzaW8kbCZRVYHLhFbP97V4lrxiw1DO+2iuMasxb8qYUrRfaXViLmUTCmxDRHCWFFUVBCAw4AWpWV/xUnVKcBTyFUf+Xi6/DuWpEsTS50+E5VUHSU8P26otwK3xiq/4ZjtxfmAwOpIvpuzv0LTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMlDby+C80ZsFBXzUwTYMj0K9R0h+axZWyef8PpsPPU=;
 b=b17Oc88clQee8EzCstueXAB+UL0c5zFoun5M7OOYhMY7BBlNlw5IvdFmC6bkMGQfp62l0BVlxjP/JIAr2+tvbQugeqRQRTXygIPM3O4vbpX1OGdAP8B8BOZ9AkAtwSMnfisf353yQ5zL+Y/G5HSYItxrqV0CLzx3D+lmt1eRjm1TxVJVD3SgEv4cBSPJdEpqC8XJ4iHLlsT1nTqvFxz3aKfCROVnfua6tD+0pwXsF65UbsIglOOT+DkL90G+Qam75zETwLKUY7tJp5ErxqL93zLL4WMWAfJLUmI/wXeglX+NuZVfhYJuN+dC2cPf6Z8umXWZwNgr4uIZziQYa3VFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMlDby+C80ZsFBXzUwTYMj0K9R0h+axZWyef8PpsPPU=;
 b=ATXy6ZrgNmp8hE4J3tPFThDE6blxktymBCVq3m8YLddeLwvL2/jCBkQnLCpwFCGZFt2Z/j+X+oTNHytQ0fFq3BREu1pUOeBoUYBMQCCPIu3oM3Djz0RLAX6PwqZFZxPUemK5S+YYjZJIKnaZXsraX1ZSFl2maOIXNQmE3Zu8DYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 16:20:53 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 16:20:53 +0000
Date: Fri, 14 Nov 2025 17:21:21 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 0/3] CXL updates for v6.19
Message-ID: <aRdXAVPp2jHwfJ8q@rric.localdomain>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <db9e4d27-057f-4bf1-9d74-008ffeb0dbc8@intel.com>
 <aRW6h127k5Tzns8R@rric.localdomain>
 <f0285498-810f-44aa-8577-e28641e97d56@intel.com>
 <aRYLJmjBsggjzA99@rric.localdomain>
 <a0881237-60e8-4bd9-b990-b72ad29c57aa@intel.com>
 <aRZBOmQH_pVs93T4@rric.localdomain>
 <aRbx1EbsGqUDY3Rd@rric.localdomain>
 <0e473cd6-12ab-425a-a5d9-b94226bed8ae@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e473cd6-12ab-425a-a5d9-b94226bed8ae@intel.com>
X-ClientProxiedBy: FR4P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 8135bb7f-dc2b-461f-1f9a-08de2399c847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qwicc6XWReFnBLG/JSFCyvqCReajjbEoi8onbfDK2ZcL5vysIrebtBsQwx5S?=
 =?us-ascii?Q?PvfhPo0/o3ThZj1DNh78RTb0la+OeAM/XkNhcC7DYgMbT2ZcrbhV+dIvQTca?=
 =?us-ascii?Q?+8l+aswId0JrOFJQ+67MzG5zdVP1SusQmYUmD8RG94vgusmuX3evGYofMEEi?=
 =?us-ascii?Q?/YBwvwc9Scs81ga3a//92r7LFCoX+6a1FqbrUCN3suKUmpizmBecUZW88VN5?=
 =?us-ascii?Q?UrMvmiBBQn3d/9ld+MVv3N/Rwx1Nucbtzo+N9PRnN7ermjq+6J7V7+1PZYcx?=
 =?us-ascii?Q?DbZcjxPijAa9hSfYVlnBFwPdqpS8l+/e381XuIuxwRxN7YNyZUhgfT0z/usT?=
 =?us-ascii?Q?2tyb+Zzc4+qDeNIQXtO8tNlB9b3tfDL377ZyWVXmvm+g9c2djB8wvAo9DBJe?=
 =?us-ascii?Q?AxcbBZMpfc79N2zwpcRWmT7iIa+7Yr23j496MR5ywD8z1hTdkx2aD+gwu+zv?=
 =?us-ascii?Q?uvwxp603UOijzfVh3GwSXDtrWTQXF9CVLsbrgbu5nzBXwyRDtoOTL1L+D2E2?=
 =?us-ascii?Q?lf+8exOxnC+PH68F7BEreD4Qu+pU35KxSTv6kYc1UIku5W64ms0oxFKYafzW?=
 =?us-ascii?Q?c208d0R1qe1WSXeqctko4cJC6bgS1D/xe3kcekRcEj5e9QcUNfFMQVMmHyxr?=
 =?us-ascii?Q?szkZYgTddRvtqNOQZa3l+1+YMpEaoxQUSTkfcksC7B9jAmFjZEWJ5n2IeG1Z?=
 =?us-ascii?Q?jdX/dfh0wtXobGY+1/9Zi3Fs3bgs3uaf9DCWJ6RjK5kemuGdaFJ93CZuFhPZ?=
 =?us-ascii?Q?jrtJ/Ap03cpunOXiQPjlV2ofRcS1dE+RAC3nmajGTSX8DFWqwUru09pAop6a?=
 =?us-ascii?Q?v87Ip/w/JG3l51oQzkVCFUs/wl3Q1ldDGBNVzyQptRmUD4ydzPIBazwlWxei?=
 =?us-ascii?Q?r7W3TnQtf/SO1F95zb/sm3/SKISEZGwc4BMylm5IQXXwuSC3uYoUv7GIiVNT?=
 =?us-ascii?Q?fWyrb+VlA1Wh0x76eAFDAaaZ7FVyIRJfrQ8C61XiV8FCao1zIBCBHOn7LHa0?=
 =?us-ascii?Q?yJiNCS5xH9D9Jqs6CFrfMY6amQCGvUMLDwiHAIfhqfI8qvsOW/WWDPqXhhFP?=
 =?us-ascii?Q?wu3HFYYcePnnbMJUEyVUDPbYwikaUG5T5Sl57yl+ZiKjQLdBmmpadikXLoC+?=
 =?us-ascii?Q?ceLR7AcyC+IIo1kQptE7//y3upLiXXTKJFmaH1Koe6O+x89ESbxxJKNimr65?=
 =?us-ascii?Q?MQQ6Z4JWlCSc9tPSl0gOp6T1e5Mh6HDmNuA38eOOVx9cOp2fRsQWOhGTEvOu?=
 =?us-ascii?Q?29Ktmx+GudG2fbUgHRlwj3y3W7tSxwMYrMCj5rGK+z1iQqR/XP2gSCA5Ab5e?=
 =?us-ascii?Q?35L0hJQLsaP9sLyopGJhzfJbo9dI36rsPs/dXLKCH3BRdHcrorxpLPpYunu6?=
 =?us-ascii?Q?UcX4JO68THa/BRK9u9CG4fLNjrrNXHl68oowCPi9C+LWUW9FknEs5q/hgqaE?=
 =?us-ascii?Q?0IS5LIUIAYQ7gNzBisX6hKBSvKBgxDO5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qQD/HMGo+73ZB4CwLCjM4owv5b6gevt+8vskLVVyMbAmeAlLs3k+1LxUU+be?=
 =?us-ascii?Q?3fwz7esdFS14l5bDnTaNzO/G89CDPvsi5x9aCX9XRQHaoPVoDipFfmuFLvWd?=
 =?us-ascii?Q?2cjWL7jbv93HmRU5WX8I2URv2BLWOBTNTUHKqe3ZkTV4pd8BxZUw7g23ZXUq?=
 =?us-ascii?Q?bYYDf8oTXU3w3KCittTYOwLPZhrlFA5UBVMHjTAK4lDQMJ+o27Ewm+VAKYv7?=
 =?us-ascii?Q?sf6weRCgC+C5WUFakTXG+MnNgDxs6KsIBLM6ybOi/ffQbj61CeMATEMRands?=
 =?us-ascii?Q?dJvbkviKKW9I2UIHqY3l8f2apJFaWN6iLE2t2E7dMBRqcZLC0b+1CfK/OKC/?=
 =?us-ascii?Q?HrQabC9NmK9kby80KayeNfmRyp6Qd49quAKz8Za3aLnFkbTuTTGBB8fU1ppk?=
 =?us-ascii?Q?vvRueEyRei302m0UjmVp9utgORK3jrvZJsF1XZ2VgjyztVcPLTN/JvZJ4MyB?=
 =?us-ascii?Q?lsh0PwXrU4MllWxhQwlfNjU9Px4wVTEXZc+yqXjTzxHHtbYFYLf0gWlyentC?=
 =?us-ascii?Q?K41YnZNiHVNMw3QTdGKePHhq8yEqC2H29PcsvFRPP/jCql4fuOFpEe5PHq5O?=
 =?us-ascii?Q?Nn5o8jQfhYONBFYfPJAfUIWBQHFifGPJgJYvd/CqJqagl+VbjkaUiArdTkJM?=
 =?us-ascii?Q?WqfQwx5lj9r2CVANqqIYokQMw3iM39mCHlEz1G9eYE2wP8oCWIaSeFwERKLM?=
 =?us-ascii?Q?IP1uXUGH4ee/uqCawYIQP46FMuAePy8N2zoeYytCC24GpcooxZqayLcjbyuX?=
 =?us-ascii?Q?pp/Wy1Slwt8ky7RwY5K9GqRLvEfX607DwpvyH0nSZLiZ3CKSVYhAABaGGOaP?=
 =?us-ascii?Q?pE32EqkLoWMC0D/t0bh4FaqYV4ISw7pj6zFCKDQUU9IDfqIoX+z040YO7UQr?=
 =?us-ascii?Q?eAFR2L8kUBy/kjzUzREG1UK+ywPFHhZOy6jtUQb4hP7B61GKCE4hkeCLpFvj?=
 =?us-ascii?Q?79hHGpznWBgU4F6pMRzMWLTBVS4+OIKLETh/4USd+8eN3aIz42z2IHPFqHzs?=
 =?us-ascii?Q?ZrHqQ/R9zxgIVhzfqUsQe/hHDIqoL5WC0yYAaACcZOFLSfm2omXY67dA+0DG?=
 =?us-ascii?Q?mrGQXAA2hgFEyGSFAW0FCA6PX+/eVp3q8vmnJ69/F+wZQqiQ9NVojn19KTWu?=
 =?us-ascii?Q?9tVri9vq8Pfsog5s84Dsih8Adtq55Ajas5xoBbGEJBb/75sLONQSJPNIpELb?=
 =?us-ascii?Q?9kJcricaB4wgy+CXjU9Is8fft7mPa82C4dvGoB2Puni9yavDSIxg6a3YQBtc?=
 =?us-ascii?Q?p/bmuwwhv+Ox6e184kjLDcRIVV4fhmZoBB7bXn64j4pAZuZ8k0cyniiqUNRH?=
 =?us-ascii?Q?uLwXptYO4fvmQWk3smlS4aASQb1n0EYKF/4XpkwSXLZFBcnTlu9xwco0rRme?=
 =?us-ascii?Q?OGcnzx6bT+jLq4hc8vQbOZH3QHd1tqHLKaK3Vu13i/CqHGoN1quja2m2RrZt?=
 =?us-ascii?Q?PIYXfTKgjTc/Eetune1m6rEgnujqJyOpM6FGqwfVhOkkAlpgC6SzVxg47L1G?=
 =?us-ascii?Q?nBFMaZZXSi7EldJxhc9EpkaTLX4tej7V9Q2N+/h7PuDJafW0l2yM4Qj6qrmr?=
 =?us-ascii?Q?oAniVCP7om9gXmX2m73vOwLZ+cU6/W4PGy4hSEOP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8135bb7f-dc2b-461f-1f9a-08de2399c847
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:20:53.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rv64YLKS/qxDPV4+RYL+BkWjgvRjzjVa2jDe8SdtPkubHzbVw3XDN/SlfnTJOe2v/uaSCTnzDLrIDWBO1N12A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077

On 14.11.25 08:32:00, Dave Jiang wrote:
> 
> 
> On 11/14/25 2:09 AM, Robert Richter wrote:
> > On 13.11.25 21:36:16, Robert Richter wrote:
> >> On 13.11.25 13:10:56, Dave Jiang wrote:
> >>> On 11/13/25 9:45 AM, Robert Richter wrote:
> > 
> >>> So currently we want to apply the 3 patches ahead of time right? Can
> >>> you 1. post the series against 6.18-rc5, 2. provide a public branch
> >>> (github or kernel.org) that merged this branch with cxl/next (given
> >>> there are expected complications) that I can reference? That's
> >>> really my preference.
> >>
> >> Ok, thanks.
> > 
> > I sent you a delta patch as I don't have a public git tree at hand
> > right now.

> That works. Have you sent it yet? I don't think I've received it. Or
> I can give you push permission to my github repo if you can give me
> your github user name.

See here:

 https://patchwork.kernel.org/project/cxl/patch/20251114090532.1323361-1-rrichter@amd.com/

-Robert
