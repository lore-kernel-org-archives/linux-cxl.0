Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B206D395DA2;
	Wed, 14 Jan 2026 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390366; cv=fail; b=FD5l3UG6lGKvdY62P9pRAObR7um1F+1/9cAwlNGC9VUTgZypzPShdKv5CcGZz29JYDaBgcYWZd5+oXkMjT1GxuIEJiI1zBZiv/Wa44Pf4i3Jqn/YGcYZ0a/5TUtkynU/UFqmaD3DpI3Gt+NcIN1edTYzwNmIii/40K/JxAfMDl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390366; c=relaxed/simple;
	bh=ObPq7ezGy8NPS5gwSljncyJ9VnZ/lwioQiss4jmXqEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HrBO/RjBwPkl+ZVIkvhyOj+4UDYy7fAFy0ABUB4n4R7ghSWeml1dywSW/8JaMK7hLZDOdU8GqtTpTQk6/nBam5UOueBegKEZcui1tqUyl061iZIf8nX2GoMMHBlpi/Mefd7LVPVt13xpNG5uauUzEqaIBn30XT0XCX1R07hMxq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x6I4xwNI; arc=fail smtp.client-ip=52.101.193.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x6I4xwNI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0PZUvEoButt+NHZdHIv91nsvowzjhlCVSTESEcAQbX73mt9CiY/lvmEWxpfcUqNkJz5cMGwq6S3clv6R0zKNkNRcugIjvnzE25WFMutv7liYaazbcH02KYLWfpYPp29dCVLnwRnRm9Nz0OSWWlhIXmCps76N/CJnqD11xt/XlOmEmAMLBjxw9EwhWThTCkJG7LaTS04yhbe0k20EJGJyv+Xul9wkzOffjOKMf1+C4XpEBfjj3EY0PeCCn144h4PI9D5nNdg3P2o5ATMSY7ZjmkXHYgCK1yCRp7zPAL0Ia35F6HXgaXjH1/E7uWBEwSV1q06sjuU4FKuZzLlNovF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gt2mFgZN1vn/tUdz/LZv4qm/UPk93gswaf5o4Y5AQSA=;
 b=kueiRWqcCqb0pn1Jercc1jzjKpI1J533aal+ZQ+I8KjVOUWyq+6pJDElUhwB8JiQbLwBFVHZy0EypArtMRxLiMl6TxhGadPS9Y3zICCclbxjEwo3M7qrrVuLpu+8JntLnleBqIkO8IhB27ALywN2uET3/k2qeMaz5Zybm401XjtVsxnEEgfw2jc9qqHVMbEwpzOIO+qMniTdkKhpYKak7HKli8eYfhlYenvoa9ndhzJIBk8srkgeTbcGiKvlq+smyNyJe3Fq+6AFpwaRcFmKf9PBMh0B1d6uCOLnHbhcmLT1e77ND0ilItMVzybiooWZaob2ag9/D1dIQ3r3EYzvDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gt2mFgZN1vn/tUdz/LZv4qm/UPk93gswaf5o4Y5AQSA=;
 b=x6I4xwNIEBGhFN1B0LOGqikBUxJOOZoFQODOGoz2m+g3cj68F0Fc7JVKfWSeGUJtAnF5XUmpRLEKHHgIj9dmVIMvG+rhvvA94dtMHpj7VIW6FQ5P4/lfGDtMXAQxCCmT6LizplokcT5qmLYGxyhleeBG7ybpsqlIWLJ+Yqvm8rU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 11:32:41 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 11:32:41 +0000
Date: Wed, 14 Jan 2026 12:32:35 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 13/13] cxl: Disable HPA/SPA translation handlers for
 Normalized Addressing
Message-ID: <aWd-08OYXJBCR0Oz@rric.localdomain>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-14-rrichter@amd.com>
 <aWcUiRJpUesoJL3G@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWcUiRJpUesoJL3G@aschofie-mobl2.lan>
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9a4755-1b86-49b7-6c98-08de5360a0a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DEAHLcfpgq615B9l1x+UXXwDJPbCQODTAdjaT0HV+B3fMSd5o92dTVIeSyef?=
 =?us-ascii?Q?6qsvES/t5uUyKdDI8F5bah25oTi3yRjeARS/LO53J8NlOPp3hTjn4EsSspC9?=
 =?us-ascii?Q?mp+iYf+LMUkmdQ0KahDVlfs8O8LFeuCM8xXcdiNhBjUeZumfTy75KDhc6j6V?=
 =?us-ascii?Q?VP/GzQOGU+Ud0ywSw934tVlr8IUyfjYW2T37xQkbdasq0cOhl3KDF6H0IQHu?=
 =?us-ascii?Q?FG7vqxQ7ynwozyHaHF5W+nDrJq4KVaFs2cRtoA6Jwxw2L2LyV5ZIic067v/M?=
 =?us-ascii?Q?ZWaYmMFWlOgYWFrHQsKRBTES0HLDkBZ297hUwk8SQ5eALwyrppiKZLUe1V1M?=
 =?us-ascii?Q?/vNUFhr7t4wdb5MC9iPBxiIUjyDLXeti/wjkBiTGvUbAX9xPJCXEJXQgf82p?=
 =?us-ascii?Q?P1ID2ubS1Hw3OWV114ls4sSLHmRvimzlS+6JrmaaxV7mWr1NpTuq8HvGWFld?=
 =?us-ascii?Q?v0t5x51o2meJWQkiIC0HBdFSzSGwjWIjYur7wsynTOGevdJU9wNWlHMlo/jC?=
 =?us-ascii?Q?iPWJZXsVSKch+KZLQfzCJRn9DBxn9dvVmRNq64Y2/WOzpkQLc1QeB32Yhb2V?=
 =?us-ascii?Q?ElJoU0WFyIy2zf5YEgG4wfZSRwub+yfYWKxe9nGI7RApPJxoDVSKW7w+VNhC?=
 =?us-ascii?Q?sLuoTf7BBDEKHKQ8fHBqN8ZtUho320t3ActYesnHSM3oQ7/klT+3R0gZmGTx?=
 =?us-ascii?Q?hVISAcxTgCmoYvHiuVVii45aOccLQfOGhhPu11SIY4/cQ40DnoMyUzQu36NW?=
 =?us-ascii?Q?pMzHC7By71gCHXgpYAiq3UCJTJaFZjFx/FsFvFzAwlzYRuUf4fJxIps4CS4D?=
 =?us-ascii?Q?JhaQe3fLVW3GqkHlxTA2k9mcIBD6r3vZgvqW3MC6eqdRXOFwkp7NIwcku1id?=
 =?us-ascii?Q?WgCXA2v7eQ+tRLOMqkPy/75i/RcP/HYObXAYK2XgJKM3gtjzeygrGgHYaaKo?=
 =?us-ascii?Q?KBSe2si6dOICtnRVR2S1li4s3g+RgaZxmumcblF2FXFIdJ/wcvnd9AdHYTRX?=
 =?us-ascii?Q?7VmhKnCFyhittPX4FsNjjmEsxygkCb8Hgaw7O2xV0jE81eY1o48QLQjJuwz9?=
 =?us-ascii?Q?bk+Uz9ZxUjGunkiGY60isDSrj614Vcb/8rqHUMdg2QGE7/fCcH/hcXuo5eZU?=
 =?us-ascii?Q?twNjOpvbxBEEZqEQdtob/zxBMcKQcHLK0r24X5D9ollUD9f8K2OFcrYFXOVz?=
 =?us-ascii?Q?Mt6WLm7QtRgqtmterSw1/Dj/vjFirnVADKV+bVjVtirZuJ66xsi8zCkDLq0R?=
 =?us-ascii?Q?1LblSR4PlwqKI79r9mQ6xg9PDrV+H42EXyPWR1IV0/iQ6vCDCQbVENY36m5/?=
 =?us-ascii?Q?yGHaMyLr4kf8rohgqrNJbv+ZO1AN4vo+9yaI4dCfSXIA3Lc9+urw6UoshUVD?=
 =?us-ascii?Q?GNiTCnZpP1MWzJadg1RFa9bFRxOqwtzn/fz/no0C1PPqLjyGXxvnkNP+8aue?=
 =?us-ascii?Q?FFe8nkN4f9qICnVoUrxHAi6h9mgZYpEtpFroxU7n8gHBK0uiS3X/HjXI/5MB?=
 =?us-ascii?Q?PUBZfOGCc7clSvZ/CmKJAr+31CCNrTD9rCZJ50U1W5XCZDYUovs8QwK2gBhq?=
 =?us-ascii?Q?v/VRnUn4O+N8GH9NHiY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eg7eLW6eSXeVBskbhHDarBycODPF+GECKJKKuDg3L1I/aXnihL5WrzlJTGIY?=
 =?us-ascii?Q?Jg/mymUf/bCYi5FO19Gt3wRAQKkg3RQoUtZ2sfPQ5IO5tFtk3rKPLf48vgWt?=
 =?us-ascii?Q?cINZFC70BZkL020CPewcK83tB/PR2zeiL62CFFBCWP+MOxruh3CngA7uxbq7?=
 =?us-ascii?Q?n7zIkUklM9GIg9C/yH9Lk0SaOgSZaxzhrZBkavSUDek/ebfPparprqYVVcXQ?=
 =?us-ascii?Q?d5qOVY1oMqoiV/uu2yPoB5DgLdb+qf/tSMTAQ7nNEvS3lcNdFygtVknZLMPq?=
 =?us-ascii?Q?sYz6WnuIlmm3vt6LrL4nkB/Xk9jbrj1pwzgxJ/s8M5WdZEmYs7lY/mpesrzI?=
 =?us-ascii?Q?ATCStVNgW5bDhLex99MndhBTVj1qJYmasDNz2SZeJNedlH3tP98FI4CGtTex?=
 =?us-ascii?Q?/HkGid8msXSinCaeIxX9FkMJJseRbDM5ougGTu/RSYAELm47LdqJk3O54tpE?=
 =?us-ascii?Q?35mh3qRBZl9I8Gth+slqWgJd3AS/Z49XSv+alBcSSQzZLwu6eN4Y/62ZRtwW?=
 =?us-ascii?Q?o3eDT/8G0Ykm7dpTIb48ydcrnjd9wVpi7YmcU8Sax0REvHr62DR58i4mgh1R?=
 =?us-ascii?Q?N4GX/KfFUUsrEdJnQC2blDYpnFrGdIyA1FES3+YsbaWPy40lDm6AtGTmhCxy?=
 =?us-ascii?Q?MlfKdn0LDf5ooJ4lN6QXEffeLGhg8Z9EK6+eUms0p/GzkB4pJ3VQnFHB3PtI?=
 =?us-ascii?Q?ewoKonWnFu4cs3fmmSpS7i7wr1KMSoe5i3kq+e/8GJ/mfrf6Tz/MybaRRhcE?=
 =?us-ascii?Q?VEzGZy9QJurKm+i///UtA8eTnswNzYIf9iCg/M+yMRsfwutbsdI5YFqKG+4u?=
 =?us-ascii?Q?omKaWelJNvZ7srt1fxQP5rVo/KgGIshJLi4ZZddS2exqa7n50CBeT7yAak7H?=
 =?us-ascii?Q?MtSzINH5G3gS85KIwdyQnYeUSaOgFJy+8KoqmVW/bdyc/0xoiDo2vEulf6l1?=
 =?us-ascii?Q?qJFwqWSMBVk2JU8ZMGvDeA7aBMUvg0n97PhuJWsmkEfZZ+JIV1+aP9bZZVlu?=
 =?us-ascii?Q?Tbf9blet9IQUn1MVqbUAGvdf4tidLwqihk6dA1OcXPSsULcHgG9bRV0y9407?=
 =?us-ascii?Q?lT7LHnXZVtoe2Nc6GZCo+y2RpCCEm4MjPrWp1kmsUU3suzEF0s73o1ZOpTXY?=
 =?us-ascii?Q?qUmPcnOd6ya/yqTHljOdAEGroehhtGvfTS4jAur/K3hI5EGlGZsRlzmljBeJ?=
 =?us-ascii?Q?Axle6/7QAVt8LD6M54O+UiKq/Ql90ffr5OIgaDRre+pEJ3Adg0KwtGEph5Rh?=
 =?us-ascii?Q?veecrKyrPel8z93oVF9nHBjId4BfbjbevOF2VdBnIQkmMRnThTTlYV6s1ixc?=
 =?us-ascii?Q?iajp6//oDfEKxSccePYAk+mv9HQn8wdOkqeYdL29tSWbozDaZsUYBhTBKLvh?=
 =?us-ascii?Q?X7+/y/bs4uOS9VZsBrmozSDpjQgmK735ekkOJ5Ah6XfVtFdfa9G1n/j/wyis?=
 =?us-ascii?Q?GAi4EhybpSLLPN9z2sjfZrHGL4DPQ9Pl87MxinWy4J1WaiNVaH8TUndU+7bH?=
 =?us-ascii?Q?9eamZIFkxbW8yNbsdomolPmpqbBJ4NaOieBpvyGT/bPfC5rXiX+95l72jT/d?=
 =?us-ascii?Q?NAtB6Tnv4COv4kuv4AvJDRVT3z2eSCcZowzBlZTEMr8xGK6ipZf3GwlbkzLA?=
 =?us-ascii?Q?wAT/QoIFrTWjDdjTL25xzi4Fe62nrFMMQQ0Vqc5ulQofFCm+Ph7jZQbfLt5O?=
 =?us-ascii?Q?3y13158FTAZLMPhLTJj+BKOuaflc+GEuKRxNTbtUTGnvoiK3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9a4755-1b86-49b7-6c98-08de5360a0a6
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 11:32:41.3052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZPJwrgoNIguU4vJCbkfNQPoKffXuf7ZYwCToXRSJcnqwbuyp1Od1DXeGNwVkhxShaM7gOznd+6Pw1d8F+CTzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089

On 13.01.26 19:59:05, Alison Schofield wrote:
> On Sat, Jan 10, 2026 at 12:46:58PM +0100, Robert Richter wrote:
> > The root decoder provides the callbacks hpa_to_spa and spa_to_hpa to
> > perform Host Physical Address (HPA) and System Physical Address
> > translations, respectively. The callbacks are required to convert
> > addresses when HPA != SPA. XOR interleaving depends on this mechanism,
> > and the necessary handlers are implemented.
> > 
> > The translation handlers are used for poison injection
> > (trace_cxl_poison, cxl_poison_inject_fops) and error handling
> > (cxl_event_trace_record).
> > 
> > In AMD Zen5 systems with Normalized Addressing, endpoint addresses are
> > not SPAs, and translation handlers are required for these features to
> > function correctly.
> > 
> > Now, as ACPI PRM translation could be expensive in tracing or error
> > handling code paths, do not yet enable translations to avoid its
> > intensive use. Instead, disable those features which are used only for
> > debugging and enhanced logging.
> > 
> > Introduce the flag CXL_REGION_F_NORM_ADDR that indicates Normalized
> > Addressing for a region and use it to disable poison injection and DPA
> > to HPA conversion.
> > 
> > Note: Dropped unused CXL_DECODER_F_MASK macro.
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> So not for the commit log, but for my closure ;) - 
> 
> A system with normalized addressing:
> 
> will still:
> 	support poison listings by memdev and by region
> 	support poison inject and clear by memdev
> 
> they'll be different, in that:
> 	if a DPA address maps into a region, the region SPA mapping will
> 	always be ULLONG_MAX. The region name will still be available and
> 	valid. That same difference applies for General Media and DRAM events.
> 	(This is the 'enhanced logging' referred to in the commit log.)
> 
> will not:
> 	support poison inject or clear by region.
> 	(This is the 'debugging' referred to in commit log.)
> 

Good conclusion. :-) Thanks for review.

-Robert
