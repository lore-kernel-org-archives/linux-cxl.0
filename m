Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6D2E0B68;
	Thu, 13 Nov 2025 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033064; cv=fail; b=kUj0uX30Phs51fWVrpEyI7ktEEvRo1Rqr3qZjVE6oD/2+x4+jcvisNK2fgcfGG84O/eEO594NAlFFLFDjAtau8pWkSfIHqbJdSXym/ea263mhKf1kpEjHOqpRiiqZT9Krr3a359Hry/uD1sAgBFFq/IJdSiysRzFujlE1uhTB0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033064; c=relaxed/simple;
	bh=Qw4dx2uCFBd5VUySgCmqR+p+UoEIiWU/eaGqvqd4+sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=USTEe2s0BLOosaNzJJ7AG5vhmJc9B3NqOp0+2ccVre84bJ5Arjvb8o17ppa7VCpCW651I7M61eq5ujjDGtxFpr+FNDMY/BPbsXKTF/XTGwqAPG25wbVWYNgcFjqU8xlkhebXD1/z+uy5kWWpIF77US2wfwrswV+bKBAndcMyydQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FjiEvGLn; arc=fail smtp.client-ip=40.93.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FjiEvGLn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfJpZkKIQjhFHtfFeb5Q7V+pHoz9imImN9eGCBbYXirgNzknhK3QWOlpAYnsaXY+HVMMnBr8H4gg6rAsWJ7VORe7yZ4+d16uF6UcKMP7ieTPnNw7KjyRv66eSw4LH2AquQW8HwUgf3BlbHmYo102toJFhZRQZEZvUXYqfUmSWEcBkPuL/zBdHvYR84zuEBZCluhr1j5p7vIMFnwGfY1c1AxKTzH2HWsUNYM1r1aabwbpVWEkLVbijmAcs9a75gSxMCNcYAIJPX4Cb/Cc9dW1K4aI0dLxeDZkabrqwjFa4Q6h3bz1VBDseMG2tD3byT30+wH2dQBjhzRx9a8Psudtgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKlXxNjSTGtrxNhAdiVKaY9S8EgGfg1pHQD4GOy7z/U=;
 b=QzwwWELhnSDX6CQa3lGmfCHqrSdUnXcAaZAd8swgWjtVrB8ks2gQ0KTJTEYHDa6F0l13FcCDSS8aOagldfbyNgdiazZzJQcM2y2a28mINAXxEPKCfN81dQUt1e0mT+xqlqMbIOY8JTuyfWMii3I6KDidLFRu2/wbF16vpTG/4FF4U1R1DKl4zZJ6v2kI1dUniofRSin84p3P4yzVFlcpQQVpATiQ1aawAnjfIhkS5dNSbXl5oHqKv3rEDhWPxc09JjPEaLFuj+uyTK5Eduzuz6WOa4XBJQvCn/pR5uRbqgzPuuw3jqyJmN24k2GCsoZRlhkO44WWITvGvsblkfWjUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKlXxNjSTGtrxNhAdiVKaY9S8EgGfg1pHQD4GOy7z/U=;
 b=FjiEvGLnhNwawxrFbkScsTdIf1WGrikLGdSpoIVrJl4qmX6IIi6FKWa4/Lhi885O69D4S+iYoobzp2TbTayafstTUYMM33V0YZAi3gBmovHNtwYt8/y6kUUwsEbrjdkCuh5cpeEr2gD4AvDynhCC2YVI9fWY1/oN6aSWIBBkH0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 11:24:17 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:24:17 +0000
Date: Thu, 13 Nov 2025 12:24:46 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 10/14] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <aRW__tkE9Ogbw3Je@rric.localdomain>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-11-rrichter@amd.com>
 <20251111153049.00005ef3@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111153049.00005ef3@huawei.com>
X-ClientProxiedBy: FR4P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::20) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ae206c-ab85-4777-55e0-08de22a72ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2b8seCZXRR4zMLoXzwFJrCBevYELfTXyS05bFP6nTfHUP55vA08EsIabNYgr?=
 =?us-ascii?Q?l3JMaG6Kkd1HP6pOTtlWE3s+fj17aSHA/WWY12JE5TIJQ62fWGWgNBjXZoaR?=
 =?us-ascii?Q?GX8fMyCjjixwqX6SuKVVjfdzr9gNcXw+U3MqRQ643uv4Xsie3Zc3li2po7Nw?=
 =?us-ascii?Q?ecH7va65D12H0CqKeg2nymV5smUStkIZdDDpG2G0nc+UjK6KuQa8JLTP49WC?=
 =?us-ascii?Q?D/uKJZv2+Wa55ktu2OC2sAETi6mbWACDCyS274M2J3KqaAib5wnvaMKPHKnd?=
 =?us-ascii?Q?jUG8NxoO+iHBGRCDSfjgWHYtvD3TnMsFASyENcxTzfUf1WYJTULtEmgzXTif?=
 =?us-ascii?Q?1Gx/aBDuCX72Do6qc46dQbqZdC2t5cX5C/of5yTbH3wu/frBoIFwjiy0gLLy?=
 =?us-ascii?Q?0ttTgITuos+/hMNXhpnk3jSRY1FXNXW14E93jiE9/AXfqfU83qjPS7atiCY8?=
 =?us-ascii?Q?HlL9L32yuG247YC1DsDA4LlgtHA4lJFGbRaDrlUySTDqBMTLynrDbc/Iw5Je?=
 =?us-ascii?Q?rPs6CL1av5azjudBCiOVeRWYo4nzp6kzuP9bI3DqRCa3gNduJaUfRkOWbUkZ?=
 =?us-ascii?Q?uKkYUPK3cKijSNUX1Ev0+aErThVCPvt/ZtjUbDbhaZfAZMMYMcsdrs+fyJcC?=
 =?us-ascii?Q?WUxRXjkb5/KJUhICWfpQmMz7mU3PHX47Jn+pony5lwLp3VWdZ/Uo1sCw49No?=
 =?us-ascii?Q?KmT6ifSJBAn029nRYRw2GxH4kDxXvoBXhx5a/Q4A5fLiw7TKw1hFFt0O7aW1?=
 =?us-ascii?Q?9vlwomlQYQNRN7NqxHEeXnKKbMraaFlOMkJBt0lIISvBLTYOIMmnAB1j4B1p?=
 =?us-ascii?Q?y1f9BBPUQmVOVKYt2PRvKN4eVaoEFoJcNPvE7PMuiYzTySraz/zNa1N2egNR?=
 =?us-ascii?Q?xPU4QiYjoSjsXa2K1NQv+CKlmfhCBo3zSk7zDocmJoZATtNXLkqmnW2eZa17?=
 =?us-ascii?Q?l2GjsOFroZQgF6T/ObIPbesG+MINvwsGDJX8x1m5rFw8vckxCxhr66mzqaro?=
 =?us-ascii?Q?u7G3440wBp0q6JGaAwG81ttZwbs+0KPRrssk7A9Y9ieH+V0Rml6yHFUyHL1G?=
 =?us-ascii?Q?FGVqoEXw7Xc2Z60Qf9L7Qkzuf+XAmpxUndDHTp0rcgGtRp1J3GYF9IK9+TWc?=
 =?us-ascii?Q?uvzB/wBTJSZIIDaeTnnTg+69l99UFoeV5vVdtk/whTI+HFSX46XT47CR3jZq?=
 =?us-ascii?Q?YEIWfHmBCSGlxfqNKBZ1PE0kYOeMfL73PL15JUdOKOVBdCAHYetOhZtUIVOh?=
 =?us-ascii?Q?+DQREvYDBx0cB0SyB//e7zi6kYWKWkwy3GpLMfl0pcFbOijypSTV/U+HKagt?=
 =?us-ascii?Q?R/HPicvq+VHEo7pxCoR8ET+Zm/UgG0HG/TQZRG5rNlWoqXCwFqN6HrQegx6G?=
 =?us-ascii?Q?H/j3XDLDRuSkZUbVUszrB2J7qZP4/uJ9F4jE2CGhYNM0mxodOyoIgPVL8sBr?=
 =?us-ascii?Q?ZPRDE/+PImN9Qd4PkyPAczoYxlfkLZGu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ahtqa6HsjwLmj29DP9SLK0+sG3BZjWStCPC+/rMpWxEtG+Cg9/+ffkdhZJnr?=
 =?us-ascii?Q?Z9tzn9peqRmBJqat3REvJapf6OMgKRFWqWSYRxZrsm7KAW/p2Qff2VxVyj7B?=
 =?us-ascii?Q?VGNZoAMxQn4jvXWmw8yuxLO6nd4rydmIsFP2TNNOhTM1cZegmyMpquLnCjk7?=
 =?us-ascii?Q?+LCDxDbhnt1G/FCeW1CaRz6TESYEeFhCJZPWHwro4MftlmqyoXSTqb5iFUo6?=
 =?us-ascii?Q?cF39d/oEnLH0PDtbB/zcHHQimVulH58/FsZwI2jNrBKMfwDKL2ExTBQ/L2qS?=
 =?us-ascii?Q?LKWYOZXqm/dIYN9nxfcs6CoY8D95X2T3uS7jI/VYwFT80RISHPLwXDHjEzaM?=
 =?us-ascii?Q?MOe0kFe/n2LLdsM8PtIg81MFc/5aVkm2P2dLwLMueDfg5N7zawONwe6+AAe5?=
 =?us-ascii?Q?5ZJgZWA7pJJ0lOZ8kOG/jutzsYIEuOMXTXlcgukFYWvUepHRQbC3XwmmmaC6?=
 =?us-ascii?Q?MVRPLSaMRC3LE12+ZWzimq5VkylzIL4mUP6KivAvyFfomzRzmJpoi0PZH7Rl?=
 =?us-ascii?Q?i0G8X0OpCotXQ3sXsW9blWiWF0sXn6U4v9clLPwYVOTbyCE/OSUtBXqrU/Hj?=
 =?us-ascii?Q?3jnD6LuuvFnU0UAkYgkC+oceprFOScFy5XiMII5FCG5Vb1q2RFVZNkpF1dpF?=
 =?us-ascii?Q?wbZAFAzhFObDR+kVvMP3pNtXCIYCvyIJ3QppFt59u366GzzDaXnqEYMtKGYX?=
 =?us-ascii?Q?s/3tn+PL004j8uig1BULmR4eAvQxj2Ymh2N/0sScFXInds4kjXX4YSeBgPHm?=
 =?us-ascii?Q?ge7IfEUg8AR0E6MjahQOLZrk1IFBPnGMZSCrei4bzkzgz15tLWu1OA9VUXB7?=
 =?us-ascii?Q?1iS08TxWjNxQLQa9SFlqmasbwSQMR2QZdRqaFhiUjOeipDPnCbd2LRvhuJ1h?=
 =?us-ascii?Q?BysyxiDJzeimTo02+1LIB3ArzhJV3BRI+JCnjI2Y8Fnzg5hImoo65GWhy76a?=
 =?us-ascii?Q?kE1VocVui/oGhOYVc15ISOGPan/HBzrLG1ZucAfuAbpliz6o0MXb7Xq0R6h7?=
 =?us-ascii?Q?HCm+PpCl7h2hVL8eRLhBbsJY/jxDHllWEGqYG97JCCYLfvGtHigIHH77hifr?=
 =?us-ascii?Q?du0Fw2osy8Fc+h98AcSQaR0FbfEUdzfVr96p9RArO4x0QylHmgd5/fEUL+Nv?=
 =?us-ascii?Q?S7adY2H8A8+ZqU3sprBYuUvi1cO1o7eBV1AgJQ1aQRDD6jrbgm7WiB+ujjb6?=
 =?us-ascii?Q?MyEz8VlYiSXWdRYA4rRgXKcao8kDnl/n6dUcdHaO58WioEL66W0wOwYMVr4Q?=
 =?us-ascii?Q?eIHvR8t+LBm3/d/sU18u3p4JLSrKW8ROsgxBHVbuL2dlR4qVRfQec0x+80ee?=
 =?us-ascii?Q?5Qpgi0F+5CJryl13x6Hd0c8I3INemT4IpgH1CZJHxDFjlpUJ2x3zYOHyBM+Z?=
 =?us-ascii?Q?yjd49QrMEre5JY1PGfhD9P2emBKR22JBR0gKetvfV1e3bPfIinlbeteb3Kcx?=
 =?us-ascii?Q?ry8w+oyPuOS05oZ9hFoi3WOE2bwCS3a1sbyQN7IALOi3hMhhYZwGjjSqSOMn?=
 =?us-ascii?Q?p3ScctBqoxloJiaVLFNcfpOYKOsE+u0zbx/9/xCiMt6hfCL9G1EXHSwpcn9h?=
 =?us-ascii?Q?kbmtf1jC8lMC5Nym0kPj1VNTy5AesElJYuozjRea?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ae206c-ab85-4777-55e0-08de22a72ed9
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:24:17.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKHOl3qOyQdHckIkXDORWTOszHC/3DGhqFRV/tLRDyjWzT1bh2v5lExkp3l7PiTJC/shYAd+zGdEtGQ/Jhq9iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685

On 11.11.25 15:30:49, Jonathan Cameron wrote:
> On Mon, 3 Nov 2025 19:47:51 +0100
> Robert Richter <rrichter@amd.com> wrote:

> > +void cxl_setup_prm_address_translation(struct cxl_root *cxl_root)
> > +{
> > +	struct device *host = cxl_root->port.uport_dev;
> > +	u64 spa;
> > +	struct prm_cxl_dpa_spa_data data = { .spa = &spa, };
> 
> Trailing comma is a tiny bit pointless as any change will have to replace
> the line anyway.  So I'd drop it. (trivial so ignore if you like ;)

I have chosen the MIT comma here, but dropped it in v5. Are you
Cambridge or Oxford? ;)

 https://xkcd.com/2995/

Thanks for your reviews.

-Robert
