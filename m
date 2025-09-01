Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769521DB15F
	for <linux-cxl@vger.kernel.org>; Mon,  1 Sep 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738094; cv=fail; b=jaAjXzNgqbE79C6Ql90eVnF3lP1NY5zbzzsDwycFV/2mWYpvjcWa21iA/nuoeQ+9Ux4nAh+sNkTU151Bc3HPvTQZxnjjRmMjmbnCDkwMIvQUVdN8v7BB5GJ2rVXz3IcDiUsAl4KhtLp8sqGhODYFlChvPZSJWkcTMqPvnYlkGlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738094; c=relaxed/simple;
	bh=X7tySGLD6gihszmchhTbDbH6c7QZ5Sn6dtLLtFSQ/2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t2MNhn2RQzlxUAmtkJjIylT/+0rsj8hs7TdFetX30VG0DDceBiF5IDoUcIV2aL39LU1FQq+Ts4uwDg7OfjSTCiSk2/pLlkcYF4JdXuc9kOdD7k0XtiqXFhIyJ7umhsEFo36WFMd/l0RPUjnV65Yne0uXxrjroEhV4xmUh87E0YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i1PsAMWj; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i1PsAMWj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFzgclTk28f3tIuhXIR2EegyrKmBpAhfBvVYHgFyHiEfiB6Qn7K9Zd51qj177Z26TYvvH4r6aLZGrHcxWCLnUqYVsR6DckLZOhBGCZwSLteRGSfT4g8hR8LwAlR9x8TrQL80eY/2WCFNE/r5f0fwnDH1uXSDTPM8VWC82IV5o27PEES+9BIdAftk270QzHrCOnxuV3gkUtOiqsLFyXf5a0JgzN1t7TMQMDOd5K6FWHF+fkX64EBjux8S5hxZvFhCcFIzBS/B4cqsvnd6D7Ov/CZQwQ/WyigdKs8ibi/e2FUGHAkBMptdUpDYe1SWwBC9sFu/FOAwf3Zze3qWtVgJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh6dUg+NSEPtfK0Grylti8dLuYzFXhCGPaPyaoYYldM=;
 b=XLveCBc5w3AqjrbWbKSMj9HCXyRCEqZz1Jf2DmAC1K7ij7C3nmnR2hEOF8vjXdrmamD2tqGCX/CGNDxAJewfb5UJSSdi4VqmMomN10ZW9c1S9v1x957CmsA8lMMTOlHodT047s6MJMkTM3KPgR3bmrTxGAw1cskt6nO8OntKnAzvQNQ+4FvXePWQZFCa6LQq0oi2J/vYRzS+SbbeeNbC17IhbCIyg4zCLyI8H+GX4xpU+Q5R6LBm0xnh13Eui51bVd38m/Z72En7obgvNM/YMjzW0JycF5D0n3h2jZ/AS1YqnfIN49iTeFCRD4vWgRuszfmu+6u+t/Eixqh+fYOtqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lh6dUg+NSEPtfK0Grylti8dLuYzFXhCGPaPyaoYYldM=;
 b=i1PsAMWjJ3bY1m76ZJ//PfdsHCM8pY3/oOk0hNI9LKPdjijY5yxtKlLSE8HPjtWhXBcN8YWUaioD7IRuDxFR/bGE197PVuaGlgV0lp/0TPGqbYLUzTuayY3duBJsrxbsi1sb6RCFq1OD0XKKPHbhKUfum/UJGvkr/0lO+kvLeRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 14:48:09 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9052.014; Mon, 1 Sep 2025
 14:48:08 +0000
Date: Mon, 1 Sep 2025 16:48:03 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v8 05/11] cxl: Defer dport allocation for switch ports
Message-ID: <aLWyIlyMgZUzO5Oa@rric.localdomain>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
 <20250814222151.3520500-6-dave.jiang@intel.com>
 <aKXCid-m65ou2WVV@rric.localdomain>
 <a5eeaa15-9ef7-4b9a-88dc-10de9f1cb551@intel.com>
 <aKg_gBw1Q29BaXdp@rric.localdomain>
 <0d4c1766-d966-43bd-abec-b1a8a4592a1b@intel.com>
 <aK1niOntTRwwZhhv@rric.localdomain>
 <780adfd8-7d3d-4acd-a34b-0e88abb40041@intel.com>
 <aLHBG5j8rVYhi9cg@rric.localdomain>
 <2f52ad40-7e85-4466-8d42-190c846fd37c@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f52ad40-7e85-4466-8d42-190c846fd37c@intel.com>
X-ClientProxiedBy: FR4P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::17) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: 2171fa56-e201-4bad-ab3c-08dde96690f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sz5XDIee8wIn9yWjG5vLK1SX+sF0yZH+UJkPSDn4SY5WSXBwkb0ide2xoEnn?=
 =?us-ascii?Q?6FAR8F/kYbtsMb/fWohQJTUArS1Io/CzmPWu8YQs6Oodn8NYshC0BRAyfD6Y?=
 =?us-ascii?Q?7miL4Vb9P75LZT+VmvvkoPG7PUCGKmh1fWOBGpih/+D1WbR/0eR73H5MnkKA?=
 =?us-ascii?Q?CGb/F6pU6hdWlzvxwnvVT1h1IGLQZYPHh6puzxutO/PDHyWJOfPukQhAWGhT?=
 =?us-ascii?Q?9H6HceYcSmXHFIvmlX83OFfJlnTCtHfYs/2aHev+OxYAlpT7UJ8B4smNpNWK?=
 =?us-ascii?Q?TkvG+ekkMX24tKDO1gTA9OLNQRXY3H05IluZWlLNI1v+eMgY9ZAzQ6sly1Lc?=
 =?us-ascii?Q?OcScaMIdCGpUDu3W2VVJp2G09/SOrvWrh0XRzgU6P60QrwVWUk7Zhy88iiFJ?=
 =?us-ascii?Q?1cJ6/2XoWWx48R8lHaLOkSyzuh4c5J1FY6zbjhLfzVk5BkHy/zOC9yEIHgll?=
 =?us-ascii?Q?Oi4lT/B/lxxJC5JMCl+U65eWJPtIINJ/ke66ptN6vsbNJUgl5c7R17fSLN9J?=
 =?us-ascii?Q?n6oqFhxDp/PE762fbNcq22uOFXryTmws7TbxrWAqlBpu/2bI22ZrVp/5vteM?=
 =?us-ascii?Q?Rt2l/kXrRo8ppTd7PqnYNYeKeMbNaxAVLiOt4cq9URGTZy2/j6kjrMzq6Ogt?=
 =?us-ascii?Q?3VgJriOJM2c0wuDOPqk4h1k6vNeycKjp9+ZduB3HztkkR004qFSPF4ecoP2Y?=
 =?us-ascii?Q?Jp8x/hs5keRS7s791J3xCW7YTJxv7xuciCVoNKeV8g/jSeh3QfMdXz1lKdHc?=
 =?us-ascii?Q?kJP0iUjQONWtv1Uyv45Uir6tUZTDn1qHfjJu4c+xR/K4MHcHmsTw9erYnYWg?=
 =?us-ascii?Q?eSm3HHPtgaS/PRfc8ae/2mjKgqhknVX5KjL1Azuvj4Rp6DAfsw84VQM6l/Y+?=
 =?us-ascii?Q?FWVQk39H1sxpMjaTPsGUMEN2abdrzhUXD77RTonxjbnaOhmo6p0MiCFEvx/r?=
 =?us-ascii?Q?z1o/hVJVGy9uE+jfJ2aRoYNFva0BV9maNC63zHk9n5XijPLnqOI7MZjx9I97?=
 =?us-ascii?Q?oC+ZWwhU6hoNVFscVU8iFq/uNR+TYjgm33UYY3rj7A18pqlSOGwYhVbyrUVc?=
 =?us-ascii?Q?2OIzO/TA0keqL52ccSWz+TTcfUPKr3jQWmU/DOI0zVmuiDp32whHcZGcmJQp?=
 =?us-ascii?Q?oey1N1RD1JPBPMjEbXh0N4J4m1wZA7KEO6FQAXw8ATsO/c+q19trlIVP4lDw?=
 =?us-ascii?Q?/oWilwlrM81Mzz41rp7BBZevahK9f01+rvT0VlNZfJLTu4pVDs+hm/ZSEkqM?=
 =?us-ascii?Q?zPkfJBS2waxBIrx9ARTQhyfAf6WO0yKOyiBheNjEEICSvbPZ4RysVmYT5cv1?=
 =?us-ascii?Q?z9sPf2XMnTqyhDIgqjJATNoRgCZT1x8RF8lrMDXyEhG9JMzur1G+01eP9vCr?=
 =?us-ascii?Q?y80PK7UyE6AgNr62fV74Gk9//izcp4rqAdc5lxY5f1hB2FQpsYFWtWcZypNc?=
 =?us-ascii?Q?InDVUcUGTls=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9+7bglCYgNKnH3UJlYkItcRoM+SlnDtJ2D+wj0sTDp0Sx6C8eikPIDwkNSfy?=
 =?us-ascii?Q?8UlQHlYcr2QCgHPumwCZIPnbECHlnLmVyM0uLWeqFp3O/Lez2zEGbSeT+FX5?=
 =?us-ascii?Q?Ynn6gZIatGqzKpuQtF6oHT+QWB4by6KZD3Ld9upVZe4ETCYPXUJkC15ssCPh?=
 =?us-ascii?Q?7edIFwaYzdcKMDLxlJYEwTgkJsaP/xTRv6BIbjLlGKs4/9TY7voG6gwHNP/C?=
 =?us-ascii?Q?CenxS5VHgfH0vScUDDY54lpRrlMCmtY9QdPHdWtt8CW3ExDhuVlNyIDf1jjU?=
 =?us-ascii?Q?6Cfxg8mr9o3rfbXrzHAH3mn1UNIOy32ZJD96kOCj7NZEdq4wioB3gNqYiKlx?=
 =?us-ascii?Q?X4wWFjwgsRQzUQG+onkJyJXFICOrmNUuX8ur67ahZjcantoyQLnZMPRCDztm?=
 =?us-ascii?Q?Gkq0/aYEBOUaaSKIaynNUcAYk9J2ELPvZIQdrcHDnyiQsFYlIjNTS6X4qcfX?=
 =?us-ascii?Q?BerrUxKjWxy7/j0PgLTWI0yU/SHarP9hcu9LhjZ2+TQuCzCIHchRgZ6R+YkK?=
 =?us-ascii?Q?1IB5SHQhYQRI1Kr+E06mCAzUSbUdXQhOnMxA84VQT0X+hc9cAMECTLImaC7+?=
 =?us-ascii?Q?u3hTOYFAQ5MJoFF9ZRazVh6L3w4ug3UFa4N5+kJ0kjJyBbQrLtASVo0ki9FV?=
 =?us-ascii?Q?pd2Z4m9c4GeFgmPCJMjBM03MO546pFU3pMx+T2qKiJdXurUFaWUP/dF1C5wV?=
 =?us-ascii?Q?Gm1nsa7W24Aqsx1roGdfFx2KUyaKGglVtsbb3ErG1Pcol+htx7SxasA2I3LT?=
 =?us-ascii?Q?KGG8S1w2pR2woGRluuOEcjVfCOE88DrGeqszhGQnDI6d6gJUbfLX6xAtxi5o?=
 =?us-ascii?Q?QloW9GZt/2XUuJ8oH0rWGcTF9Dl4cqex4/NfHe+qj5jtjQnsPd+o2mOaf9E/?=
 =?us-ascii?Q?/OVjpSY++Eo6dv5zd9P0Tb3b8k59xodV6inANTsr6t729rkztMxzsti1sEG7?=
 =?us-ascii?Q?JZvWl8F5Hu16JUlBO+HdmTU38/mXzynSonuEMki9ScZ1WVB0FDqSgjORF4pS?=
 =?us-ascii?Q?DptC94aZeFKqiiVPV9Mjte2SfqlvP13sy3Pxu0GfCdAhjE/9BFS7ZO+Fq7+Q?=
 =?us-ascii?Q?GTySE0GJBR4qnWHGy2aflLEbgMZk/m6wezXJoW04Bkk3llbprJZhz+7Xzo6D?=
 =?us-ascii?Q?bTQVrzcdiRQIaxDH5s3xHHpMVqof1M2ONcZ7lYfH8ETAiLUBmB7fDfU2nLQJ?=
 =?us-ascii?Q?SKjC6KH1s2GN9+aeMiom/1stZFztO+DVIs8EeENLpQa/73T85ViMmhy4qe4F?=
 =?us-ascii?Q?Jae8dMuX8sngqEw855gOknnwjozbJMudn8Wi/X1Im6K1gKnmuzkhmmOEeF+z?=
 =?us-ascii?Q?pzB0hk/hgpl5GokFel2v22lMJxwkndwcx9OPn4f/IvkO3qzQwcJq/QnNqmQ5?=
 =?us-ascii?Q?d0IXz4CQKYo7agxCRWHX8JMpIxr1l1BeNGTg5OCfOhlybyd6xTbPGRtA7sZi?=
 =?us-ascii?Q?rk7wlOfnNkmUyWBjdnCeFcfxVVgBZ5g0C9wNg3z09sspbgJ/Vz/BKC7QRO33?=
 =?us-ascii?Q?DiFZ0fTD1HkA+RtGazB8OCPitkttgq6FoOLzVuRmDgoNWoB/Xb9Rumh9GOF+?=
 =?us-ascii?Q?N+AziIpuHzH/uv2kIGVUuy7NHzNT9WiYASYo0URB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2171fa56-e201-4bad-ab3c-08dde96690f9
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:48:08.8361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ppWoPMSdvrORkdauQumD9bm4D+sQ/FmD2lAX1j4QUDDUXLI9X8vGcuBl+AxAbTBvBSfyJNyReB8CX7tRLjR9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686

On 29.08.25 10:23:38, Dave Jiang wrote:
> 
> 
> On 8/29/25 8:02 AM, Robert Richter wrote:
> > On 27.08.25 10:05:05, Dave Jiang wrote:
> >>
> >>
> >> On 8/26/25 12:51 AM, Robert Richter wrote:
> >>> On 22.08.25 08:52:39, Dave Jiang wrote:
> >>>>
> >>>>
> >>>> On 8/22/25 2:59 AM, Robert Richter wrote:
> >>>>> On 20.08.25 08:20:04, Dave Jiang wrote:
> >>>>>> On 8/20/25 5:41 AM, Robert Richter wrote:
> >>>>>>> Hi Dave,
> >>>>>>>
> >>>>>>> see my comments below.
> >>>>>>>
> >>>>>>> On 14.08.25 15:21:45, Dave Jiang wrote:
> >>>>>>
> >>>>>> <--snip-->
> >>>>>>  
> >>>>>>>> +	if (IS_ERR(new_dport))
> >>>>>>>> +		return new_dport;
> >>>>>>>> +
> >>>>>>>> +	cxl_switch_parse_cdat(port);
> >>>>>>>> +
> >>>>>>>> +	/*
> >>>>>>>> +	 * First instance of dport appearing, need to setup the port, including
> >>>>>>>> +	 * allocating decoders.
> >>>>>>>> +	 */
> >>>>>>>> +	if (port->nr_dports == 1) {
> >>>>>>>> +		rc = cxl_switch_port_setup(port);

I want to come back to my previous comment that port setup should be
done as part of the port enumeration in devm_cxl_enumerate_ports().
No need to make this a special case here. The link should be up
already once the mem dev is visible.

> >>>>>>>
> >>>>>>> Can't this be done with port creation? I don't see a reason doing this
> >>>>>>> late at this point.
> >>>>>>
> >>>>>
> >>>>>> The main reason we are doing this is to move the port register
> >>>>>> probing until we know the CXL link is established. Otherwise when
> >>>>>> cxl_acpi does probe and calls add_host_bridge_uport(), that
> >>>>>> devm_cxl_add_port() can trigger errors if the platform BIOS enables
> >>>>>> PCI hotplug support on Intel platforms. The error messages "cxl
> >>>>>> portN: Couldn't locate the CXL.cache and CXL.mem capability array
> >>>>>> header" is observed. Essentially we can be trying to map registers
> >>>>>> while DVSEC ID 3 and/or 7 has not appeared yet. And in turn because
> >>>>>> that got pushed out, so did the decoder enumeration.
> >>>>>
> >>>>> The code suggests the Component Registers of the CXL Host Bridge are
> >>>>> not yet ready. Is this delayed after the first Root Port is connected
> >>>>> to a CXL Endpoint/Switch? PCIe DVSEC ID 3 and 7
> >>>>> (CXL_DVSEC_PORT_EXTENSIONS, CXL_DVSEC_PCIE_FLEXBUS_PORT) are part of
> >>>>> the pcie config space, which is enumerated not before a CXL endpoint
> >>>>> becomes active. I haven't found a spec refs here. Please explain.
> >>>>
> >>>
> >>>> So the behavior is observed when PCIe hotplug support is turned on
> >>>> in BIOS for the Intel platform. A CXL device is plugged in to a RP
> >>>> without CXL switches. The thinking is that the CXL link is not fully
> >>>> established at the time when cxl_acpi_probe() is running and the
> >>>> ports are being added. And the only way to 100% be sure the link is
> >>>> established is when we are enumerating the memdev just like the
> >>>> dports. Not sure what spec ref are you looking for. Table 8-2
> >>>> indicates that those 2 DVSECs are mandatory for CXL root ports. Lack
> >>>> of presence means either the RP isn't CXL or the CXL link isn't
> >>>> established yet. I would assume this would also be true if a CXL
> >>>> memdev is hot-plugged into a slot post boot.
> >>>
> >>> But add_host_bridge_uport() only creates ports for the host bridge
> >>> (ACPI0016) devices and enumerates their component registers (CHBCR).
> >>
> >> And I think that's where the issue is. The component registers via CHBCR isn't there. When I removed this change, this is the signature I get:
> >>
> >> [ 37.423882] cxl_acpi:cxl_get_chbs:589: acpi ACPI0016:03: UID found: 35  
> >> [ 37.424180] cxl_acpi:add_host_bridge_uport:726: acpi ACPI0016:03: CHBCR found for UID 35: 0x00000  
> >> 000aabf0000  
> >> [ 37.424186] cxl_core:cxl_port_alloc:741: pci0000:3a: host-bridge: pci0000:3a  
> >> [ 37.424210] cxl_core:cxl_map_regblock:426: cxl port2: Mapped CXL Memory Device resource 0x0000000  
> >> 0aabf0000  
> >> [ 37.424213] cxl_core:cxl_probe_component_regs:55: cxl port2: Couldn't locate the CXL.cache and CXL.mem capability array header.
> > 
> > Hmm, hot-added Host Bridges (and I would count this case to those)
> > should use the ACPI _CBR method. That is, else the host bridge should
> > be enumerated during boot.
> 
> host bridges are there, just not the component registers in the CHBCR it appears.
> 
> > 
> > Is it just a delay, or does the CHBCR come up not earlier than the
> > root port link is up?
> 
> Let me get that clarification from the BIOS people.
> 
> > 
> > Can -EAGAIN be used to reload the driver later if CHBCR init fails?
> > IMO, the Component Registers cannot be initialized later as that would
> > delay the enablement of the root decoders too. At least only bridges
> > that fail to init the CHBCR should be delayed.
> 

> I don't follow why this is an issue. Auto region assembly doesn't
> start until the port hierarchy is established via the first
> endpoint. So by the time the region code pokes at the decoder
> registers during region assembly, the component register for CHBCR
> should have been probed. It seems reasonable to setup the component
> registers when we find the first dport and thus indicate that
> everything should be there. Are you observing an issue on a
> platform?

It would be good to see the bridges in the system regardless of the
link status of the root ports, which I think is possible. Same with
the chbcr and the hb decoders. Only defer it if not yet available and,
let's mark it as a quirk or workaround. Btw, this is not a delayed
dport enablement any longer.

I am also a bit worried about the conditions to run the setup. What if
there are multiple hotplug ports, why should the CHBCR be ready with
the first one already? Shouldn't all connected ports come up first?

> > 
> > The issue and the changes for this are not obvious, please make a
> > separate patch for that separate change.
> 
> It was in this [1] patch.
> 
> https://lore.kernel.org/linux-cxl/20250814222151.3520500-5-dave.jiang@intel.com/
> 
> I think the name of the function being discussed confused things. It is now renamed to setup decoders instead of just setup.

Yes, but there is this additional change that calls
cxl_switch_port_setup() in this patch.

-Robert

> 
> DJ
> 
> > 
> > Thanks,
> > 
> > -Robert
