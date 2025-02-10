Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1847B16F271;
	Mon, 10 Feb 2025 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185651; cv=fail; b=HKoIRwEvpG+NI7pFmtdWCrBiayVztgjlq1pF7TeEkioKzdTW8zyoutsHm6g4hUVLkWIGsckqsfAo8GWVI3OQxNC0OWjYqXN9I51iFH7RpE3cUqSGlkODmzPP8Azr1yYlFPD/L6ixDFFFava+JrUm/FoT3I3WobEsYeiyLXe0qNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185651; c=relaxed/simple;
	bh=ZX46mN9tECn7BRaKNV+q7WVaO/gNyO5DduHCO/5znYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PhYpUtcktKCKEw8Y+fa2fkdlCRgznNxGy8SrMRnPuMWEs9qqmzNYnaYvu6ollNOoLNKam0WV6/X90wEdvaLAJSoyKAMcr02Un6fLFYIWM72zeNyoIyKzzEt7ST2uP5KCO22TJjNDdxwpPOpe8aWz/pN2t1/CRLWXxcXxTpeR6SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vw35ZXzO; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vw35ZXzO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gl0w8gjSOaX6ORZh3pCHzsOm+3/mEneJ7xn7iUKpXoLceb3svEcl4F1wBrrCvFCqN17DIZFJbDsCxVyEPsj0u+peHiXiIIHQWjw8oCDDwFfvHKbjd8krExY4myNN8ewhhl+xCeSNn5/fy8wSj5xO99UGz2/shbaG/+HZBW7urFcqEnFjVRlJYoZTDFv06HbAQLG8k2awlrK1LEWsyqFeYY11GDGTITtPRUZINqoThkamzveEpvkypPu6IWao83HyO6R1Ip7902lAqYFgtNWhZjFKIycXSTpPfYwIt+xfZrFXPxJ/iWeRPyaHMm8OXnE3XpOshvbi2TzV20wGHdhgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eygjou8LQRbxVavVMhtlU4zs6XKBe6KtLHhQsYvd3+c=;
 b=rXMi76s1tG2f4SyHvzswUtMmnLMZzCSYbWz4CeNg8YPdSRAQPehBy3W2943oMAC0Se/Wn5XTTsB1KX9gkE1arq32thl58cDgnf14AKNQ0UF+NCqIMlcjws8r8yNNI4dtFRxY6Nfmac3REWre4RodVOFfjbif/W0lxA8miYmWBzAz7XQZNIrOW8UN5p0s9oKt1ZA2Fao7QQg8eUUY652tcOlu9jk462V6p+rnk+AXiBH26DsnRaC5kFoVRRZUrd89WIT1UsAYzi9mxbGm8nTnuR/eeZtU2mvKTcMc/DFUEXhz3+8I/XuOveNgPomQGUtWcezwzLmh7yhFRk8O6ITNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eygjou8LQRbxVavVMhtlU4zs6XKBe6KtLHhQsYvd3+c=;
 b=vw35ZXzOxrtNsZsCW4xttacUFfbj2bAWT6qOdMPpkZieUxoDFxTKHv3wYejHazHMgfeOpOL1ZvIseYajCUsnHCFtBjz2Wn2N7KeO2T+UKtseRthpjsDTEzONIcyhF9mhatRmU32dId8xnTK0ow4oz5oIFrjSnpmPPtNavG4j904=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 11:07:27 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 11:07:27 +0000
Date: Mon, 10 Feb 2025 12:07:20 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Jim Kao <jim.kao@xconn-tech.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 03/18] cxl/pci: cxl_hdm_decode_init: Move comment
Message-ID: <Z6nd6Hwi7wP4QxVH@rric.localdomain>
References: <20250207153753.418849-1-rrichter@amd.com>
 <20250207153753.418849-4-rrichter@amd.com>
 <Z6YurVy_K96jet3U@gourry-fedora-PF4VCD3F>
 <BYAPR06MB413558D98731EBD422CF24E4A1F12@BYAPR06MB4135.namprd06.prod.outlook.com>
 <Z6aHBuGwuEMy6Kc1@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6aHBuGwuEMy6Kc1@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR0P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::16) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d2d96a-0dc3-4ee2-c3ed-08dd49c31a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6cMLrPLj+MbvVI2Vl54PnU7edwvJKB+wH7rIwD/GhiPNOY4M++BkFY+tMIHC?=
 =?us-ascii?Q?mplYkp+RXAf7GKb6JxxOmfiGCZH07L8MVlcE3piuDOSzJbXDSMYW9ucr6ap0?=
 =?us-ascii?Q?tFiW6x0TAUaubW2t3Aitzc0t2ERbN3G7SyybJJd1clNQGuvpgwExb7PZxLp6?=
 =?us-ascii?Q?MHnnKL+Db5vL/0VSBkAy1nfglpQlak6WbDlocDAw3akUeuLuyo1ReEaq4t8g?=
 =?us-ascii?Q?LnyJfcRA9EXzh5+rhQQWMZ/ZPp4J6mUU/Ok2OhtBRJNwIRPXcKubWiJAKzUn?=
 =?us-ascii?Q?z3N5tZShd7JgcHG8WssudvJVKh4hzeV+peWUY+xc/JD36wXkLUl0pbV70Gpd?=
 =?us-ascii?Q?Ax5FIOs7uzbMlCwH1PHmOk3sTAekmK0I+7vx2406Ls6bhMzKu/4kw9Ele28x?=
 =?us-ascii?Q?DDuW6JjWoP6yyIg8TtgolaVIDmDG2G4DO4RYu4rMeynbFrN+G0R4vS2TIINW?=
 =?us-ascii?Q?SZEhjmo0cWf+3PO7ZjA5AJhsoS9XQGnDBcmZk9Lgw23g1+47haEXX2A2e16l?=
 =?us-ascii?Q?FRTix5gefGOYocWKa7odKA4/J+xKYYvTPnP4I8I0pvjKh9diRbpbcanb58/M?=
 =?us-ascii?Q?NijVHbaW1z+RA5B1OA5FVI+Oo+id84tQ5SrN1+Gt93wlxg17Q5UxPj/f/xoM?=
 =?us-ascii?Q?/c30SBHVAcaZmBFutr5lKMbpmR38/SzXtamP4NTt/I4ZcjHvL+vYdK0sBy7a?=
 =?us-ascii?Q?SobjPZezNtRExfDZSrr0LqREaTjrfRHo+yaZ4JLS+p77DgLaAQWr5JQT6mjm?=
 =?us-ascii?Q?BzCqYM+PouwWmn0TKM4p3KcwwKBfwHY7SsjC+AMnd2Ap0rRW+lLeC/Ww/i8K?=
 =?us-ascii?Q?cZpvphbaPY+jhMCNY4kM8PJJG02ZnF7tAlRiSZQU5YeH6ERR1f4yBywqkKPE?=
 =?us-ascii?Q?L1mul1yCi1SuG5P1L3563Uw2P6GYP65GFe/9ILdMAvOyGHTEZ6uPPsJqAGvG?=
 =?us-ascii?Q?a7s9rdHCGcoLSEKjOMb1qnmkZZIrQDDFY/gp0Yk52IAnIyux/Z97uwQxf/3B?=
 =?us-ascii?Q?3ggeWhCGMTfvZ3rnUCksgLz4sgV5+Xo1icuzC0MCCxNJRqRDXv7tT4F1vAfE?=
 =?us-ascii?Q?GRAQfKCyJsRahlFWs3RoFMYZ5gzlnaxqKL/JA0Ekn70u57o/1xcSxPihN/2J?=
 =?us-ascii?Q?gZMZkagbIOsqypVCbB7YaIaQP07CT9oOMW+TvKsw9wNQD3UNZZxEHgrm+GY/?=
 =?us-ascii?Q?rOShixlCsrxWRpLo2TQ0metc2J1domI3eKXMUd4stfHsgAOoip8Yi6gH1NXp?=
 =?us-ascii?Q?1ckshalJPbUDknNsZZq6mQmh+GWE8rPq4ybZl5Skaw5QRS2kIOGTsiNb98x/?=
 =?us-ascii?Q?ae7c5RZtbID/hNlkWs/Z1B3E/tRwqkKH4hbUVqwQp4BRqskCYjQivBINIG9K?=
 =?us-ascii?Q?rGd5fwC3UczdEzrw3VzLm6M/NGzu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3fbxhdyPxcXbTldfzwb2cvn0otbaV16qX/6WrRgpe+td32KFV2EWwILxYHet?=
 =?us-ascii?Q?aw7NCqk2PR9DSTV2ecqYymC4dPGohtbLG2EHmd3wTdxIZg6ELeNZfhLIQPsm?=
 =?us-ascii?Q?//h/ub9EcHuG2VZyVkjRX+Y4AR1yQaUEg0FNz00DaE3QNQcOexgPZMzg/GDl?=
 =?us-ascii?Q?5+zunjdO2pqy4ogQsLkg3l/VkYVz5phnNYkOZyAEyeuJ3w2MwrfWvhHQ4Foe?=
 =?us-ascii?Q?tPOMz0+tB7Mip4zfrVNBtewjtSkqElR39Uovd9vd0wsTA9lzfeQIRNj2bewg?=
 =?us-ascii?Q?2+rD18CYlCJsGY1nJcGM24o7kcp1rN5GDoRTahfE4O2/zXu0dhaefUPnxUBp?=
 =?us-ascii?Q?avXKEJ115TOXiBnyjqhDEJgqdfZ4gdUjPY9Rfv+aniM3x4OBb6iiZlw8JFki?=
 =?us-ascii?Q?3dyhz/ugf0zjbHhrUcA0KN4GsU8I2/1gNt+3KC+8un74dvyk5rKkGf68dXG+?=
 =?us-ascii?Q?fL8fcxHXyd1LeeKuCbDx++WVXUj8Neb10JDhgPR0ICtBKQPMNsf/UXMENkKs?=
 =?us-ascii?Q?+p5CFtVll6slf/mnM9MWEWbQ2964OLjt4GbSIK1kk0MoLxs2iJYVdumAGyEs?=
 =?us-ascii?Q?LvR3otbEYHixGFeovhIcydSqbZxpSVf5MesKvahnc4Za/M3kyO1isViRfLFy?=
 =?us-ascii?Q?H2Qoo1EIGXjK6BqDSFzMnE2Soa5UCMH/JGQcFxJDrGfSQcjFk3ivTJwnEcbZ?=
 =?us-ascii?Q?/4vo1lkVUPhXq8XajJ6b92iXwnPW3wQ96rf6vY5MqCEKmDKWAXEItWgW724Z?=
 =?us-ascii?Q?5yX7nl7v2VVeR/y3UCqt/PwD7Rb/F6RPDY4B5r8kQj638z+CWS44LAa1zGZQ?=
 =?us-ascii?Q?hTzopO0ZWniu4Ia0o4sWBJjxCRlE8PLPQPf152+c6WC5PwpklMCMBo0WBTtb?=
 =?us-ascii?Q?C9VCoKJZVCEQRrLVtcT9YM+zIgbduVOc5eQMUAzU8qc9VFRUkr43hXSSaHi+?=
 =?us-ascii?Q?sZBSekEbwoMxTD9wGq2o9yN0hE7fMb79K29OaA4tcCShNhohhWo1c2xeMUc/?=
 =?us-ascii?Q?3ckbdm7+WI92I+FpiDhdU4YtJSftGPFphEnHUVWV6Lf8SSvjYChRxRX/kZ+N?=
 =?us-ascii?Q?ciYaFbGXZXGAmKcz/jbBMTib7lgfE1ZGbnK2x4ylhZFplsq0Ryp/c2HClF66?=
 =?us-ascii?Q?puDKL72xwK7bJaXzyZrYQgzmTGZC3ZrAaJ7EQwB4vMuRjeiFytn28SiwL4at?=
 =?us-ascii?Q?FntbPi/n5sDFLeofie3hcUJrkHSJ4kut9KEmV7iFSZzAy/0CeBda1xIxJdSS?=
 =?us-ascii?Q?J3j7uICURzsketsepDMHV7cGlch8gAmtelu5ch2m4sHNr5WoXrwq37JOuhbC?=
 =?us-ascii?Q?/AjhOo7QeVI29dymsSg51kWhO9i5PzpLRzZm2/E8vDpMAE8/VgQsQlwVGJB+?=
 =?us-ascii?Q?wxbmF7b4LXPbnynDIllnCRZjz2mBdUhojzofoZKkvNJkxFfPO5vw/DGz3r46?=
 =?us-ascii?Q?C42n5Htdenl181aHq5sGv40sVtlenza+Jzgu3sTPrVn06eyOW0I5QjhNFKmS?=
 =?us-ascii?Q?amqFVSEcyM4Auk8wQdCUDKcOcNuCHoZewgNHDUEld0EXlrscHFASIGpyuvwN?=
 =?us-ascii?Q?AMEI/0suImavJ1jysnWdcs2r2Y82Ro2+UnK/4Odm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d2d96a-0dc3-4ee2-c3ed-08dd49c31a95
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:07:27.2585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eb82G7/73dfWSujfqapX0BgL4IO49N/mBErchfkG9i7DXMHyR1NOHYo6nN8bln1c0GUDNcI4U4LBluDmLOYUTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924

On 07.02.25 17:19:50, Gregory Price wrote:
> On Fri, Feb 07, 2025 at 09:36:08PM +0000, Jim Kao wrote:
> > Do we have any limitation for HDM Decoder Range in Linux Kernel ?
> > We has observed that Linux might be hung if range is larger than 8TB.
> > 
> > Jim
> > 
> 
> Do you have any additional details? dmesg/core dumps, etc?
> 
> Seems pretty suspicious that it happens right on the 44-bit boundary.

I am not aware of limitations from CXL spec or driver. AMD platforms
support a much larger physical address range.

-Robert
