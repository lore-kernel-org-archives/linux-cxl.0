Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8AF1F3FF4
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097640; cv=fail; b=pIwikeLVanRyGd0CeXACTEiocW2c1vGe9qUaXIPqxE+Zj/cOxgLc2UrkthKnSBHDpYzDhzEwKeqjXrzmFV5BrAXvA0oR5Y5h/pvmfFETVX0UaMCLIFfwDU1gNdfeGB5G4N3Ob7FomN3C/RA+72Qx3gzePMlAIGP2QbZ+3aS+onw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097640; c=relaxed/simple;
	bh=I+mNv+p743//qA8p4nJrUxnpJ2zC1OJdKcB1PeOxqa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JtxFIo6ajmUmfrS537afGBToDnX+HAEfF4SIRo6IRQ1UCtTEP7BF9tG+OfwHDvf96fFuaxQ+tGuYpO4edRwA7bTMXDES0GH9N72a7UKmyIb73GXiH0S9lq8ol5bWeCKlH6SEg+K4+gfHwQg+a9ajkBpTF+P0ag7s11MTAPXUKu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zVdVyFt5; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zVdVyFt5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OT/R1n0GSbYePu2nqCV+LSQ9rAsat27jjhvGjmqdWb9O0A/RttjcpuPWFWnjA+flTdalZaUXQ7GGC1AifFcD1ThLUA2y5zRb5aXoEHxn59CK5NWHLYniti1WDwtcJjDNAVVr9yN1nrrJfn+a794HP/yiO4ukUVkwbXA8xazAIcCJeLrNIczvRhU5u/q9gnxCgpY70cU9x1ZM4/F5WZzHTIa3bS1lLYzo9yXsFqam3J4AToEz48wHpnHufGVOr9Zt5cKlri2KzsfpM7H6dKaamEZ5v+8wboq4esSP9B7x1cbVdYa0p+va7/vo8eEkz1WZR/VXzSiwsh00B2HrwG65pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yT5JUW01ryd2cC5SAK0DtqyvjI9nMhOBoxuCJPQVduc=;
 b=vIiSDarx2zbA/PHGefXd5qKk8WJFELJfLwC259kOe25PpuD6INsXxd17I9XO05VJ7WyoeSAehu81J8ryw79XaGB9w47KoPnPgkqUjgKgyxA/Ae/0P8NTpVaWFJZ6h1s8niThVYautBZXOcWULanRxY8SRslznkulJn/3NPBj/dakG8G9OtbBPA0yLG98AY+7TxaaJ+Y0VKpI9+DO8U3prvoRBUjURAIl0BEGLQG6gCQG/Awg4TgFvboNRL80pqlOX8BnJZAAcgemtO/jhgzVLCjscsOKCEd6rRsTb0pJ8MhLCAyBDskc0tHgh7WoewEMOT+tP+iOx9QAfohsA2I1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT5JUW01ryd2cC5SAK0DtqyvjI9nMhOBoxuCJPQVduc=;
 b=zVdVyFt5d97kwMdar8z3CYrAxDKxvbQ0W2lpc7rXowJF75WelCrWCLuyQQuHL8pgSsFTSGHV1YFnvu5BTvGurhX66BZ4wJd7+iEJJ6XvUsvJ03v62mykXxEhcgjwbLP5SuZLyH39VKP3C+J0tdY4H5ifNb2csxD5ERqTq/UeYic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 11:33:55 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 11:33:54 +0000
Date: Mon, 21 Jul 2025 13:33:49 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, Gregory Price <gourry@gourry.net>,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v7 01/10] cxl/region: Add decoder check to
 check_commit_order()
Message-ID: <aH4lnVnF4nuIoIng@rric.localdomain>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714223527.461147-2-dave.jiang@intel.com>
X-ClientProxiedBy: FR4P281CA0394.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::12) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: f30deb8b-b657-4541-8805-08ddc84a7954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CPJ0ivxAbqK41ezDa/aYGbrfLPpZGdSUpblxgerohrEMEk4U1LMwfPC7UX50?=
 =?us-ascii?Q?1+hNfRrCuKN5wJNrK6FFpivTjdLHCbzcVvfKUwW3JYgaRHIM6FXrzPOSpvyV?=
 =?us-ascii?Q?5E64RT53Y+OZ5+Se+3HQ+fm/f4iOW/zZjoyGXzi61fki7p1dSFJSD7jTC/bu?=
 =?us-ascii?Q?RjR+OsJifL8m4UMqjMCsRci6AV3pRS3Gz9uFmVTTJpntjmGy32LnQptpTvNM?=
 =?us-ascii?Q?w31LzFwGEUEf/fAXIrRWYbO40IqBA8QXYzXiKybME2sRqlZslsujKfR0kFqX?=
 =?us-ascii?Q?2C8im94ouYv90mUDVKmOTK5ULHtlVNBKyFkHsEmqL0ddVk/ORifPF247yBYg?=
 =?us-ascii?Q?JUXVhldBdRqLyeyRvm6w4FeaNI0MlUkzLNowtzBTpucDJ5jTlPKc/XJAPK4j?=
 =?us-ascii?Q?nl9gKRdX8WbmDNYbYaUEICd+2N3IJT+3PHhhu3ctlHoFz3KzwpF6BaHUy0X9?=
 =?us-ascii?Q?xswAmD+AsocWyJ6rNWrn0VBBjgqw9ZlVaq4+UoakeJEKKkUXdBuAPwjyULzL?=
 =?us-ascii?Q?+6DmCtTh4/sUPlXtpP3eczAWYKvW3x3zS5Ml02CV0dZx9YAQt6Bq2Irafg6n?=
 =?us-ascii?Q?fYutl02IoPoBHLp8kYiXuDca3KPviqwSaGbk3iokEq9OxC77auOxuZgtPyJz?=
 =?us-ascii?Q?hqi1QQP/e2G/ou7ElAzFbiMyOkW/pLujxhPdeCogBC8h+fCRc7jAjq9CfHfo?=
 =?us-ascii?Q?BVBIDLSueRbbTaUvtOAkzrPV5SE+9+BCdXiRBT9q887mFC+f2bXps3HZsxPo?=
 =?us-ascii?Q?Ho7XCCZkhfb8APojmQqzBE+VEuDoR6tLk/sz8aJtM44jgoD0UFp/ibRj4cNe?=
 =?us-ascii?Q?WyFLG4HLQBWkYglYASRwWn/g9DqIhw00dw8s4Z15GMHzeETZSChtll7msMRM?=
 =?us-ascii?Q?VaAOU9iy1ylXwtL6dyNPdssN8AiR9o8N2cKUhFOjlwvOeb8Nye7lAFv+IdRN?=
 =?us-ascii?Q?9tdV16CyjfRgJz9RFG3QsLzbDubziodBV1KybOu+8SJ/47emzNwwXTRdIK8H?=
 =?us-ascii?Q?N14lvuFc0v/NdBion/Kzxs348GopXoHXNHMQWyY8uLH/meUKlfnIDWO6jtpn?=
 =?us-ascii?Q?5g9uib7ykgvGsqR4yxgXo61LsdezNids70l8aBWe0opBqU1RmgZnR9ENZ+3A?=
 =?us-ascii?Q?TuADp6LsiNl/162c9XMQm7W97EXHdgySz5618jC059tZOyPr+qZpFxypeW8V?=
 =?us-ascii?Q?qzgsc/mdHqBeNAgp/ZkHhszcMlsm+I+Mr0YC2MMWfgicvF+ZTv34RW7i902f?=
 =?us-ascii?Q?P+UyF4rZ+Zr3PUD3mS6+etSq3p/dGU++cqN7K7Gd2+3lWpVU92jRafVSlDFx?=
 =?us-ascii?Q?KX/V8aPGLpBTAUevO3Do6Mi6uCV/8IwEBHOWk9C9kauvyjs1ttZZKKQu+8Qb?=
 =?us-ascii?Q?yzbZobpHus+E87xOYAi8ydLgu42nV1bV9U0YE0g2J5UXfa0+lU1BaZHPp+s4?=
 =?us-ascii?Q?5yDe3kquQyc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+oGJS01xPv/LvvqeHja0c1hy1NGLWNm2NJR/CPg5k5/GYAy7girB8itJEy+q?=
 =?us-ascii?Q?j9Is6cQ999bAZxmC/1Iys8Ytwn5sJ2dPO5HPosTM2hVWVcg8ie+bjroBJRMm?=
 =?us-ascii?Q?VJHHwKFbHtiMlRWdfGqThb9IQTDGZRz25V/EM3gQ+j1HgwFEQbwl3h1DPpxT?=
 =?us-ascii?Q?OfCQloo6SwUF5mGVs5m+OXju/K6yXe4RwhfHlHzTlFthIYm+jK8L53HqIBy9?=
 =?us-ascii?Q?ZF07d6u88h74GxpMnWC0Ks1l3OoCWzZBLYGShlvFGDSGoWxYCoTeEzhsRQaL?=
 =?us-ascii?Q?T+faTPlwXxkORjAr30Wb5WcNVqM8roib3QIGpIY5YRUSzGDEu2hmCs8LGR36?=
 =?us-ascii?Q?A2vxDk8+oQhWAW/9dEGCVdzxsy2lG1YdQ6XKep8DMEygYAXu7heijNPNqaVm?=
 =?us-ascii?Q?J0pAsqPSO4msGtgQ4NtfIHE8uvEYCcAlgsx9lBrpM1JbmTDk/wQAdlIUtsAC?=
 =?us-ascii?Q?MH2Lw0dIwitS6jO0FmOOO2FGsBDoDxpRRyUgjB+/DcGwU78DPPTrlKjRjxxO?=
 =?us-ascii?Q?5ctKm9yvRT3T8cJbaGct0isLUxdA4NlCD6kmPmRX7FE3BSihIFUZquq+/MAO?=
 =?us-ascii?Q?OjY03UB/B2ffXGoIx4q5qccXMhpKWzU84QnkKewMQGmqJWYB36oMkFyAlbSQ?=
 =?us-ascii?Q?LlC2x5FFU4rIlX323y/EIqxNbZj51zSU8CnYeNIp1gvEltb3jXJ3CGd4S/9b?=
 =?us-ascii?Q?A80HKneMdElQ45f0ewqgWMX/Hj5LfMhuf7JIgmhbqMbi5fNCny84dHYYODwH?=
 =?us-ascii?Q?idIjywHwHMkMTtLxIx2LFcg5pyKpIb8G3ttEkQnNYd2YCsa9pgs+696buOlf?=
 =?us-ascii?Q?ttfMo6WqkBhSu0lmFb+ompWGDtO87G8xQijo/WfUNTlN8vKPd1bZTt0d938B?=
 =?us-ascii?Q?UP2HkB+zVpqTPYK3LSa0bQjQXrzW/lh+Pbi5upPoOv4WiZUU45LdsbXsV+Zt?=
 =?us-ascii?Q?/VVn1fo9GbsyMf4Y9V/IffsNFMzN4EZ1W4xH7uJ8GopfvIU7OFxsM0fnAlb/?=
 =?us-ascii?Q?7klfFakGEMn2GGiqu4yH3iVATEpnfA7SWWMkgwguliW0i6gKmLltigYj3nnx?=
 =?us-ascii?Q?oaSFv+A8TP8ANkkggAVo9rgYxiUFPnHdVXP/Sx2ZrPfwFWHYmbdwbhzY2LVM?=
 =?us-ascii?Q?t6cdd0yUJz8U/nnUCK8OBybKPQoMAe8a4QJn/jVUXBIb3/bE/hs7ewZmVI4R?=
 =?us-ascii?Q?fRbz4pupefXQEr97tFPZf2zMu7ZRu4o8cStuf17R9R+GLHQ4Qa0lC3arZ8n4?=
 =?us-ascii?Q?McoKFSSq7IVmvlCnO1HqKnNz6oC2BXZbjzM/NPR8l7ImBIkE/65+Go5LLx7H?=
 =?us-ascii?Q?c4TDToo6+HAx2gZ6NFl5jdoJpIsv7JWX5TqYSHmBphx3+QSk0wEfiis9Mu1z?=
 =?us-ascii?Q?fnpNAvmzD24HcJP0HHoMtb6p7l0UcuVhPh/wTVKye7UJKWOGEU1pYIz7OS4M?=
 =?us-ascii?Q?DzAVZ3FOaHgX5daZ9xGZ0muY9pzMW6OojxTGsWWpG3ytS2hQc7L7NScIPCpz?=
 =?us-ascii?Q?+n+1kTwiMxos2uCPTDHiAVPGpUjV72HXGio8R3c7nlvGYucnwKMSu3DVpu14?=
 =?us-ascii?Q?Dcpf5VC0YRuR/zx6J3WOa90PFCKFEvxbEVJrXxs1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30deb8b-b657-4541-8805-08ddc84a7954
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 11:33:54.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eROKyrN8HgL1Hxyh3dWWJ2Z01Q8eezyYwcrPaemSD8Pk1r2XVmIs0Ps/6usGGgTY7FILWfOKodzel7IdsJrrPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649

On 14.07.25 15:35:18, Dave Jiang wrote:
> check_commit_order() attempts to convert a device to a decoder without
> making sure the device is a decoder. So far this has been working due
> to pure luck. Issue discovered while doing deferred dport probing when
> child ports are now in the midst of decoders due to ordering change
> of child port additions. Add a check before attempting to do decoder
> conversion.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Robert Richter <rrichter@amd.com>

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
