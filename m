Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B559D4A07;
	Fri,  7 Nov 2025 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530284; cv=fail; b=lUv74Sr60kb19B+iDNXL8aoRvjK6J4wg0TZ8UAQJA+Aoh8R83yFfIjTX1QO/yG1x9gXcfrTD4EoAnrnSkaJ3CSxmnqSQ+jwU9z9X41jmJijd6c+SRKA9ATU+FJm9yNOinu7stKXOdxPhcSZkqknfkb8DdOMLbkSsQ0Qc2hBCn+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530284; c=relaxed/simple;
	bh=tbbJ7UfHiOzt1kOOAi2KWUpGYpHWOtHpuS7j8wHn+y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n17Kt+oDM1ZqxT2zAkx2y+8aEv7TL/ylHYTuuJ1AZHZhoTRYGAKjiTkAsrBFmB71qv6MrfjGObOMbtmEd183jiF4D/8P3YiAMgIkt2GZdeSMEdnN2YFFqq78bX0cy+Wndo21G0GaFdJxWiJy2//s8nsiW2sSAi6cuPGJO1t4e6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4+NuCZ6R; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4+NuCZ6R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcNZgayEghYRrup5A8tSC9YBDuWLw2Xp7+b2zJwubia12xnu7LQfOn8aqxIztUoiFeif8091yjm+nDW+XRCxs1FLRmslmpE9M14Klp+04l/pnse9FvIr/Ed47K8ziPRwZOmVVeJIwzXQE8eWiTzG5x+XFrelr6xuHa+8BKJh5eMkGDCfc8oO/GeaGX8lVQDaaX6SziR3pKJfqykHmX48BSVUKx9qOxO8a42IcHnOkdTqovdpTmHjYTk0Q5izkSlVyInqWwJHOCPM3vbUL2WbnoM5CR4J5wx7wstzawyJiamFHssjfy8GW1yW8ig4VjiciBeKpDPw1ahz3+MivHSgsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AfASvbxKU5MK27blvabYSWme8RtS3Lc/TplyfZxTgg=;
 b=QM4t92AEk/QaRb9997qVpAAsp6Ulci+6TdioaD31keK+a3E3k9dEPREj/S8877HlMtA2ylUgmFWu9ZwaTTdoN0SJL/OeMPUvgwQvQwoXm/knavB4aDFVEgOCd9JcBTZRNz8jU1b/d6YOjLQ7YDYx1+j7jzb1DY6H+6AbjSK7fdguxat1/rZ49NZKYLeSKxK8R/2iHjYwNzCRJhgYx8W3bslLi5S9/RWSPcc98FBIgH9Xrb4VODvBrGY9+W88NI/kSLMZBzP4Q/iKacycuMsWu5KXVB7k/MFdWuR1tN5qnSwJ91o2lFAukGfoNEj2tb6bnt0pRlHe9ai7aueLtgxYrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AfASvbxKU5MK27blvabYSWme8RtS3Lc/TplyfZxTgg=;
 b=4+NuCZ6RtflI8T1FEhXxQDoEknnlSIcLpGpGhJwtTRKa4FnwJSrBi1Vu+M2I9+aqrb06JzaUcaWNXoSfJul1ugDMUxmcy1rtcbwi8bdgC9IBvu3sE7n3YXlRNOU4cwLc8WqE0RioU/y2N8wA391UnZ/jKu/eA1KKBUw4ng9YDRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS0PR12MB9726.namprd12.prod.outlook.com (2603:10b6:8:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 7 Nov
 2025 15:44:40 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 15:44:38 +0000
Date: Fri, 7 Nov 2025 16:45:04 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 05/14] cxl: Simplify cxl_root_ops allocation and
 handling
Message-ID: <aQ4UADgeq6NH1lwl@rric.localdomain>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-6-rrichter@amd.com>
 <1ef139d0-2a27-40aa-8b08-09d9ec89791d@intel.com>
 <b361d492-1cc1-4057-8114-851240dd64d6@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b361d492-1cc1-4057-8114-851240dd64d6@intel.com>
X-ClientProxiedBy: FR4P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::7) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS0PR12MB9726:EE_
X-MS-Office365-Filtering-Correlation-Id: b09e3255-903a-487c-6269-08de1e148ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BMEPvhWw+TKri62vC9Uq2ZKaWEphqd54xVXnz2rDmkcbahGRJLkYzSuAWMuj?=
 =?us-ascii?Q?xhndnW6T7CO1r+svheHPre0BQ03fMGmVveTQUljyhtfEerfzG0FckqmEypuC?=
 =?us-ascii?Q?RrZQBqdVdMZUO3pl5ggQY6OOjKewKZ1JTnOKIRVN69t0pnNtxQvk8apII8dT?=
 =?us-ascii?Q?2t4mGMWq0+x4YPasjcwSrQrdRr6VXqIE2bPHrANO+SjZM699D9/s+Pbaqadj?=
 =?us-ascii?Q?BoXgAu6EL7JnevBmMEZJ6LSfYQ7HKkHeJLterkKn+nn8BpHEVVW1p5E1LWBI?=
 =?us-ascii?Q?Sa3EnTKyEBpGnCEOkSvPh3ec6+HlTDoHY/xtfRLZ2YiBOAd4pGEGHmG2hNEe?=
 =?us-ascii?Q?sIV/isBWiplW9amVEjqBnWEdDbW2NDrA9vZ5E0nGFzXH7wIv3X2h3HtJUXMn?=
 =?us-ascii?Q?xb4O1o1n3FLC9VoX4QwRQ+4hYiyJu3pu+paz+JTiBUa9/cY0E6JODeRj5Vye?=
 =?us-ascii?Q?L79mTyV+1pS2vNB6+c9J3joVCgxfL7iaTtCSplRifp5/AtO1glbi2OZ0IdTB?=
 =?us-ascii?Q?AIq8pF0qedFZE4v0BAuqgHMkLmektWMT2kow8rsNus3GMzjSsJNvnL6YmXbY?=
 =?us-ascii?Q?iNCGWfrcOuf5+X60i8qV4UokEojseN73Vv3Zpc1JixzEy06V99myZo5dscK9?=
 =?us-ascii?Q?Uh6vuR2ycesaSvCHvfEczsanJASawO3wpVEM/WBinGYHeNDoc+9llcXI3Amq?=
 =?us-ascii?Q?Wh7WHa/q8kfSJUnHCyHZZbYiKOYYi77FMZlGEcbWoswhKTs37UGGCPuFxwDw?=
 =?us-ascii?Q?aGrVS/0AZ9420T4fpGqsxWptYGlqB7GuPt86AFHRdOpg3/L6Day8ocKxQxt0?=
 =?us-ascii?Q?CyluLoB3hp8s1dSFDoTCw2c+sZEAtFGg0/n88X7LWgIqxE1D2OzaQT1cKwTe?=
 =?us-ascii?Q?yS5w1QtrYPKIZSpj2QboKAT9sXHkA7tJY2UV4SprAy7PNPWn/0pZStOKyMlL?=
 =?us-ascii?Q?Pd1JBlmpN2+r9CVMeAFAytcw7b/KbY4REbIuxrPScVoVyRVyurTrhMyfYbjb?=
 =?us-ascii?Q?Mdp2aPTCJVN1sa0C9LcUFU5uJ3ScjPmys0fDng8XrWFGY1sArJU683gzFrlB?=
 =?us-ascii?Q?qIvwquYwx8p6ONAkPnON17Ki+1xFoQ9Hk/iJL6rpzmTsP6+ryQRaCDzrioJ4?=
 =?us-ascii?Q?rAYstcA449KHxkkYrglCcxxvCuiiKdEeXsBVBrVn2gpSE+tEtcA8mS2+4M33?=
 =?us-ascii?Q?2Ouch/s67/VjjAQdB0/CDsRfGWSXXYYM/jfxMKQa5Ii+NvoCy/l6OIPJaTOU?=
 =?us-ascii?Q?enB9XnghI/2+uYWGZNZq38itZNBzsK/CJ4RBtV1N3CMbF1B/WyZHPGIoKkZw?=
 =?us-ascii?Q?YSbX7nmBGMScFi7N8EeAso3LMrKdXiXmdrrryw0xaeZ7S6kuBLn23Q3YinPq?=
 =?us-ascii?Q?0hNUWbhOHivw43KnHVtq0kmfWy+uE8pbN4QbiBzd6j9aTvjtAQTNxGfqBUmp?=
 =?us-ascii?Q?Zuu/mOadXNR3Q7ENNj2O+diP/JfE2Eap?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I9r96M0TgfxFFRSlqJDu4h0g8KfSFY1awTYiGnZuI+LonnhcOS7TEhNaVV1I?=
 =?us-ascii?Q?9USwEqTLsLr1Xld1qcI4g174ay0P1vRIsUvg7euPE5euewgyw42qvjnZ09AK?=
 =?us-ascii?Q?s8y2gUJJi63mzmrtLiZxwZe3yfnuSHzgft4KslSJ+Lekoo82/kMYWdAuruhK?=
 =?us-ascii?Q?yVMKn303PPaCglYb+qKzeUg9TY7cabD1RIUMR7SyPl/cuNqt00BAsqBHmt+E?=
 =?us-ascii?Q?UAcP7sK+DxnYccurjnoZVpxzF5ZjUXJ5oC4A6WcV0ysTUCs3hoi4IEI/+yXx?=
 =?us-ascii?Q?raqWBqjPFjrSX2XU5WjiGQuC5APUkcxs2gBy+n3xp/oysDUDyPjh6GFYz7CU?=
 =?us-ascii?Q?wTAHPNzSfNeb+B2NRFEDyHIB03yJcIejE8JqduPGQiTb7p2JFjCIGZB6l4tX?=
 =?us-ascii?Q?A3Lk9GOvOK5/91DmpFPYFcFq27qcFYBPmUYvlLfs1gBDvm6+VXGQ5nRMOjgG?=
 =?us-ascii?Q?8iza8izQBewx5tGKq2R15y6dfINYGZfEER62DIcLVo9xNC1JnIXEOLXAY/1N?=
 =?us-ascii?Q?ivvKJWccjYw9Ab4P/WPUYVQwKuDhnSg0kfs9fHnNnCYZWaEfBVLCZgWr1VCp?=
 =?us-ascii?Q?aOe/iDZJKtPzqX6hwluP9ZInGOmUXeL89m977KgByGxAS792spMVHcYH9dqd?=
 =?us-ascii?Q?iX0iW085ijkD9lsQBBXdOxlsa7fsYOPFY2XvYW1VmneNfL2BBWz//Oq5rzAT?=
 =?us-ascii?Q?upzoVlV35k/2siZIKO3n4y3uvvj5+iFRBVdpjaZiY8r2/YXB65ie3euk/FEh?=
 =?us-ascii?Q?cOnwJT5myaOQC5lsvdOQ8yj0vvaBa+KywzYoxfcWGJqqZ+Hd7C7MvFQFFrHQ?=
 =?us-ascii?Q?u+pN1HRKwhWoZCFy2Xo+wOnMWRQVEyHD+d0Hhfl06WEb1rCkcOwO8yS0Yu0m?=
 =?us-ascii?Q?T9kBp+gaNiNdtzbPh8UPWwR+kJcLTR55vOGHqLQ4UlnBSA/KDy1Dg0fd8zCh?=
 =?us-ascii?Q?PVfwguscfx4XUT4CM99egEexRGiF+Fn2zDP+FzHAZngDAuHNjpRaOBoSMKTJ?=
 =?us-ascii?Q?dqQvgJ3C9aEb3CLPL8GlfVk5z00YCcHCU72o9uuMpjS1F/sjazd1EBdrLA6y?=
 =?us-ascii?Q?6D17Lnw2/XKFn/t3enR5wzLPCNIcxbLRBjKHEotlUFnUSDGWPBnLSu766k9Q?=
 =?us-ascii?Q?EaMPM//iwoBuzKR8i8easpvyzc3DDJSN5IXXHL5Hy1+YfUYlVhQjg660F9LK?=
 =?us-ascii?Q?7cfJ2tVxxokpbxxVKs1ogode3Ud4rvBvGHkwtNziZslpHS5sIDUBLlibf9KZ?=
 =?us-ascii?Q?z/nzyFkvQAumXuUqq4vLqDQ8sQTr4kwoOtuMv4oqjVY6a8kUXYCVvRPpqQYz?=
 =?us-ascii?Q?VLRm7qeGic92YN2Qp9Jy17D1WzmbliYp+uoVjoi5etfrOhZJ6Zxsl2repWa4?=
 =?us-ascii?Q?sO8sbaj44SxGB9cH2jti/P/4hfTLtk7c6FU0+AB+pL0qN856/iTyog9FpQl6?=
 =?us-ascii?Q?Mj1qQ2D/7iG11CsLLe0T2gXkZexLlZ4WCm62HRXs9PvvYDK1sdH4qNMP3p+T?=
 =?us-ascii?Q?lxr43L5W61i8UVSjTKFkC+2jlqW9NbjNau/OOJP+FW8IE3gPtbh/3bXv4kR8?=
 =?us-ascii?Q?UVpp5K3WgmrXIKVbBB6RuyPpUWpFnCCcWATrfV6c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09e3255-903a-487c-6269-08de1e148ef3
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 15:44:38.3283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIcPLSuUYK5OuELt2UlI9PpYkCvW2kBCUj5g5X0ow1Y6NAv/rOn50IIZ/pAz7ZKVbd2g25w02LonkL1syeIgBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9726

On 04.11.25 16:02:04, Dave Jiang wrote:
> 
> 
> On 11/3/25 2:53 PM, Dave Jiang wrote:
> > 
> > 
> > On 11/3/25 11:47 AM, Robert Richter wrote:
> >> A root port's callback handlers are collected in struct cxl_root_ops.
> >> The structure is dynamically allocated, though it contains only a
> >> single pointer in it. This also requires to check two pointers to
> >> check for the existance of a callback.
> >>
> >> Simplify the allocation, release and handler check by embedding the
> >> ops statical in struct cxl_root.
> >>
> >> Signed-off-by: Robert Richter <rrichter@amd.com>
> > 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> 

> Thought about it for a bit, should the callback be with 'cxl_rd_ops'
> and the rest of the translation functions under the root decoder
> rather than cxl_root_ops with the cxl root? That seems to be the
> better fit.

The handler for address translation is needed to determine the root
decoders. Because of that the cxl_rd_ops cannot be used to hold the
callback reference. The use of cxl_root_ops works since the pci tree
can be walked to get the cxl root without any cxl specific knowledge.
A description of that is already in the patch that adds the callback.

I haven't evaluated moving qos to cxl_rd_ops as this is not the scope
of the series.

-Robert
