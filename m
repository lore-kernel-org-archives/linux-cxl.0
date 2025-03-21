Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42D4431;
	Fri, 21 Mar 2025 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553739; cv=fail; b=dIBOT576kQjlL1nnAzi4qAaqd8sS1l6pRDutx5c/oetUy8ik9gokyecidHO/kvUtn6v0+//dlodvw256RzJAGulAu70JCNW3aVG6jZ0TSHIu/dUxF9Pt05ALNuoaUAQ8JBLYcW0OWJEX5xL9Q4j3/9+yOJV/Xls2Vui9Zh5oMtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553739; c=relaxed/simple;
	bh=Rv8+ehSeY/iQ6TPf4BUgqADIfS8R37fwU3qSTPv3HsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=osyjdMw4P6iqgTa2rXmVIJCASjpJtLo9hd3QzC3mxQ73gLGqI2uU4ja01DeTLEOo5iqZ15WNc36AYmXkP9bPC3Z7yTTxwDI80YYDWTyRvRyfjTtaDgQKtSWBT0iBrjxpEu577Tva3k98IvVYIGqfBfXKUCS3fj+6E6WsddHbFmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lu3UMeex; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lu3UMeex"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9NhtBnPtIRyJD7oKDyMTWegBSsviL3d7swWlR09EWu8b5lD/8cQkp467kNdqxv/FP1ShR/7tjgkBuKmlAyHOHLiGijLGyBnsWNvakjZlgEixOEHS40bWjJY/LEyt2d5KhGJ7AwLPVcEQd2geiAaS5+EmZYSOrhB29bYO2EIAZaj4lD7cK/41hJ9ryIrKyMRtCVYe/9BfqPywCdZSYxHVyfHWtkDm2VzvCmkxUOTJz2qH3jc1j4yQXyO0Vx4B+CHpNLT6d+RaCYV221KveAfY541hbmPWzCMxGJF0Xc1Sbtd+ojaydTh0TSet7UOi7f/0buR2mZWbfU6A+jomV6xFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duZ200moSc8Qv2AJ/W03HlK+N52LBNZ9caZ8fEfQC5M=;
 b=BXcgE6M8wZO4AWxjG9X76dStaja2ZZC5NmrtaqACbyZSbXUW1xEbB51zfsXlPgt7lKtf7Awii/LeyahKPtV4UwcxKJ6eiVJ9fW9/yZV2NnGaplLX5KLBO3dzEV3l0FDzfjnJhLSWaEjrmoV6NNpTpGhMkvuu5mGxJtkFZeDqlIexAEE5K2u2Dk1GhK0tDDiSEHvt39RAHpcfoFh5OZAL03Iu2Dz0myL1lfAQntpfudwqQEOhqs9dg4UX67VyqAi3YfOMCTMiR/NHSQYqCMX68PANByjSiAAGPnapL7B5CoBTkQ2yxKsaHyhvTWPMVF2kPRNNwn9uK85VpNxYF9IN7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duZ200moSc8Qv2AJ/W03HlK+N52LBNZ9caZ8fEfQC5M=;
 b=lu3UMeexKsd5+oTiBbyTvT4sd+XqIgZ4L5udbWz3J8MRP7oSzbBULG8N03eBnWGhiQdppDyYhJdWfz9U2Dg+utPy6WP/hC6Bi+V2tWZsOsLNipx1LIcoSNpLs4MhbVPJi2wFCGIdrm+lTS+YHt1UPayY8vqZoZcatdrdTUnkd8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 10:42:15 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 10:42:15 +0000
Date: Fri, 21 Mar 2025 11:42:09 +0100
From: Robert Richter <rrichter@amd.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, ming.li@zohomail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/4 v3] cxl/test: Simulate an x86 Low Memory Hole for
 tests
Message-ID: <Z91CgQjzXzKWNXPX@rric.localdomain>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-5-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314113708.759808-5-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA1PR12MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 717a5d38-982a-421d-f373-08dd68650bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C/a3zfmETZ2OtlvBQIE9mIAF5kadgeIj7MNsazQzcs5L2sspIWPnoUhx1idu?=
 =?us-ascii?Q?U+Kfzcouar9sPP22HvLUAkwNJS5e2XDbuLiUDuNQIICK2Wp8uOZwiEgaMljb?=
 =?us-ascii?Q?BttGNayidGN/ljobrV/3vIff+b6a/RbUxv42Ea4v+8vMkE0P7gZ78BSWZQia?=
 =?us-ascii?Q?JTdL56RiXpdfavIieJTwXjJcDyBhXpsX5ulih49fGMV1GhCg/fC9pVIufvKE?=
 =?us-ascii?Q?3EgZTpvRjCPkYFoa03ZP+mYVZowDoC7PVxGHuGZvjGWzXPWmKaxmzWRupehJ?=
 =?us-ascii?Q?RLv3xO2O73Y9n7P7lfCbGZuwmsSc6MXNcc22jZvMiG33KjHTmk7Vx86F/cxg?=
 =?us-ascii?Q?0Epu/grkokYDzzmzGLlFXfuIvEpZZZdxOMUTM8ydm8KeRhPkKA9yyp/5BHKK?=
 =?us-ascii?Q?3Zr+MHxx/86XazQ3MUeflhnZUA+XEsiqmJCqTsbE4Y98l2WzrLlt4zEyUhJ0?=
 =?us-ascii?Q?SFTl/WLcvgHmO9Rq34O3PKuwNIbOaCwfKNipqUXwZ3Q/LTr7TU9bu+z6k18c?=
 =?us-ascii?Q?CbGfgiMkXT7gFY9ZeR/sacWMXfykmWoVIg0UzdcRjqDnU29O608VrmTYAcr3?=
 =?us-ascii?Q?Q74Hf97nQvtdHfBrpoQ3OK5pBHAF3fPTqdYfpYZWQcf7Xg1aJi/HOvOx1fWi?=
 =?us-ascii?Q?xrSEzXEQcj/E3B3iyy5SCo3lbt0aygJNeQ2gt6/Kzec+nkuLApLRhpe0QCCq?=
 =?us-ascii?Q?WgGI9NFx6nfrhksEToP74HxSQQGZA66nUOL6t/aWNNMn4lEqIoGcP12SE6c2?=
 =?us-ascii?Q?dtHMor+WKHmr5vQ5DcMwFZJBk142EXIMtBgTyBDSu1CBIv9ljmsTg60wfe87?=
 =?us-ascii?Q?glPDKdcfa+h6BSi1p82dIpe1YANSc/zQ3hXkVU6COeaF98fRsVHKQCYzyH9R?=
 =?us-ascii?Q?cDT17WSUqWaEXN1BwTZApwQGgjOOiflF7EPpWat0KgJAUG8KQLg0AWYKrnfD?=
 =?us-ascii?Q?ZPeGBeWZEKElJpXtW6sCOOPF7bc7nI09NKGILkV0M7wBNZnzSWOqMthqEHzn?=
 =?us-ascii?Q?/N/jToz5eP5Wd647dMex3eQJCuVekcZhOHMIaxbrj3+WAm5CcgOq83orSX7z?=
 =?us-ascii?Q?yZXX/dJWA7xndPWL0Gt4dbNPzMqVl+q46bN9FqjxLV8BaojAbn+kL0wSwdUu?=
 =?us-ascii?Q?aTd7wOosZe2m5w//hLDJZBFbWgBKRlwyZrwuZZUraJakTafWqKk1bdaD3AEy?=
 =?us-ascii?Q?+1TJ6lPs4nD+1cnal1OJznX/GD2ASLDkpTl0vZnKbyXfJDHbEmxwG6RbHyX1?=
 =?us-ascii?Q?hGFYOX9hTItQDHNoeOFwqJECZrixWSz+unkkh7UMMyc3KEydUITDnV9yXx3y?=
 =?us-ascii?Q?4/4JruAO4GPNlLqg2yk4XUSXBKLw477LkHccAFEp5MP2M4nKIOlpLK/edCwc?=
 =?us-ascii?Q?jX0uEI3wCbwz5xCTGcWftUmnsGQU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1+d7Cd+3wJBrxO2pQmjO87a4ZWJAbJ4nmt1adD02hTu8/tBYsKYL9xNpNu7P?=
 =?us-ascii?Q?ddm6HI+xPUqxq1iW5AwLz6frrdV7sDXr0dmNlVr8Kuo9pP11Lt3t2Yzfqyq8?=
 =?us-ascii?Q?r9vQPQT0iAJG+TphyekRLe/k9i4jwzkgFFi0qCo1KUCXKkYiqPjCKjx9ojvq?=
 =?us-ascii?Q?KvnmLVDpyZdp96pHCqH95MNz64K6S3yJiAoUFthLkBaHwCGc3ZilluwmanqQ?=
 =?us-ascii?Q?Du3ajVn5aZ4fjFrTStzaCxhUFPorBaTHYcyNor73vc6Ci3qUQikLGNbxYEhG?=
 =?us-ascii?Q?pLrZKWkB64xYkqWZAj0ryHmyqRQUaPHf7ICdxjaGuk0EPsS3EKwFxhxFpQ+k?=
 =?us-ascii?Q?KQVranRj0mH7NMWbDoSNs7BOmLIjdvGmNj5mWcY33DxNlRyDkTc21TbLavXl?=
 =?us-ascii?Q?5+yCF8WGghYrKaBa70DPEZ37fOwZaG9tPvBW1fKacFpKmWyQqg2mi059XcRP?=
 =?us-ascii?Q?uikshBVq+rCF4wjRX+I5pzBjNxrPRy8VesZqjoCgVGrs0qHYuqWLyRSOpr0y?=
 =?us-ascii?Q?YF+buD3QzwkxGXOIEBLWw7cp5rKYiXSaX7ZGVEYeap/6J74oMFgj/56kNaF/?=
 =?us-ascii?Q?fPURlm+ix47p3xYS6tPCc4qCBoIvXiGpOtjIGFBWo90KOvLZTLCXMTo0bW8A?=
 =?us-ascii?Q?51Avh0IT0tD2OQXKhBTX+D0cJXCwifBfr7KsDFLCcDCMNIWvo6b1pxUxY/S7?=
 =?us-ascii?Q?PEQVD8plB583G1dF4mUyPyeJ84RYYP2c+J5QR/KlnWcivGzgvucOjZLG2w0R?=
 =?us-ascii?Q?vVKYp0L5kDGheUhLoL1k4hf/wTIxHziYfWzRrxTAIXgQI86aA1Hu3fXOmo3A?=
 =?us-ascii?Q?4f0JNEtWN0xofhYNIYw7J/7jnobTVbzxtkChJS8EUTFNQgfEDIMgrx/o2WOO?=
 =?us-ascii?Q?LJLMzwgSFo31M35XOWdgHnaDCY/rOfi4AI67adydBXuKWFB1pWFfHR2TuwdE?=
 =?us-ascii?Q?BkEEMfFm0yWAj2yhc5HSafpwnNvHPYmK16BU+jF2aTAS4oesz5gCTmdTQ9se?=
 =?us-ascii?Q?nIaIh5v4ebpvjBRhke4tARF9bNdwoSMyf4vvg1xAkxw4GjNePXs9jKkewKpV?=
 =?us-ascii?Q?ZgHyMPjnEbDZ8a1E3GW4PoY4c6UmvTZVH7jeco0+U8GyroU9KBfQV0F/sWYs?=
 =?us-ascii?Q?598+0E07UHyD9Kxo4wtiNjEtbRRYa/c/1uXpf4Ru4wa1eB0JfpQykKsbZkOz?=
 =?us-ascii?Q?80xiyjVD96gdJwd94CmYE73LIsAc/11pPGBMggXulMCur7kTmbO3wdoZiDxP?=
 =?us-ascii?Q?byLKLRczUYQGCVMRxzMirIhFjmSh0C9FH+f0Cz/awCWH8EX+6iG4wPXzwIdi?=
 =?us-ascii?Q?IHvd7z5nMYJRjrKmyTc4m15KE4sTmYl0UwBbZAfm8Umx/b7hcG7ak2ciNzZ1?=
 =?us-ascii?Q?WLp5UYXJpjlZ6koe7Je7nmaS1lI6ePySVWISRmZQQmBNnYWq3MLOqrUvJH2S?=
 =?us-ascii?Q?87RSFntqG4ijD7ilVAUwTJHefDcqV6M5amfjHqA2pNeMZeAjoMoIisrmeN3C?=
 =?us-ascii?Q?IN+CdtAh+D9RGHrQiVzXsuY199C9JtIHb8r8M5uvDPYTpIAlsb1maaeXhGGO?=
 =?us-ascii?Q?3a+W+qGycZNaFd5Asrcad1ZchBN7rpPeH3ML+Wo7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717a5d38-982a-421d-f373-08dd68650bbe
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 10:42:15.5768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBN33pBJu7Hg4WbIjBM0bnjTYFOTsAgjG8RWmFYH0zDA/0tCTfufY10Q71fRz3jLuDjjV6HFPuJ83h6dplEgFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637

On 14.03.25 12:36:33, Fabio M. De Francesco wrote:
> Simulate an x86 Low Memory Hole for the CXL tests by changing the first
> mock CFMWS range size to 768MB and the CXL Endpoint Decoder HPA range sizes
> to 1GB.
> 
> Since the auto-created region of cxl-test uses mock_cfmws[0], whose range
> base address is typically different from the one published by the BIOS on
> real hardware, the driver would fail to create and attach CXL Regions if
> it was run on the mock environment created by cxl-tests.
> 
> Therefore, save the mock_cfmsw[0] range base_hpa and reuse it to match CXL
> Root Decoders and Regions with Endpoint Decoders when the driver is run on
> mock devices.
> 
> Since the auto-created region of cxl-test uses mock_cfmws[0], the
> LMH path in the CXL Driver will be exercised every time the cxl-test
> module is loaded. Executing unit test: cxl-topology.sh, confirms the
> region created successfully with a LMH.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/lmh.c               | 35 ++++++++++++++++++++++++----
>  drivers/cxl/core/lmh.h               |  2 ++

Can you take a look to move all those changes to testing/? This
indicates the interface of your mock functions need improvement.

-Robert

>  tools/testing/cxl/cxl_core_exports.c |  2 ++
>  tools/testing/cxl/test/cxl.c         | 10 ++++++++
>  4 files changed, 45 insertions(+), 4 deletions(-)
