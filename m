Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE542C21E6;
	Wed,  1 Apr 2026 03:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775015464; cv=fail; b=eFIi9XheiWdoctGroLcwx61biOyT/IB5ykpSO0T6w6Zuuooa0pO9uMSlEJ3X0L8CHTzllP+Vw6usl2hT1F/1OaEBFjkqlozb8j7ZOY5MHyTXbC+DJcdeau50H64YoQpH7A9mLnPNWSI/rSVZecYm5WC8pKQxZkd+n0PBegHUaLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775015464; c=relaxed/simple;
	bh=MFnr15IdLFYmj9JIV+amZtsazQHJwJCCsKArz8nz08Y=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=rdmMDoj1/eAJFFY5QXlQwJ3Mk+ZzcxTuG0e4TtbKIGSjlTXNLOK54/6vtxXI+Y08fVryKH4BlQDRUntIr2ho09JP987eRmjlS7CNe9dFBLX3B8LEtEWDxG7aAPbY6emPZ+WwAikGm3hEefa+dk8xzM+dNfLLVkCrwbQEd6hCt0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ie7UuuFa; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ie7UuuFa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775015463; x=1806551463;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=MFnr15IdLFYmj9JIV+amZtsazQHJwJCCsKArz8nz08Y=;
  b=Ie7UuuFavkm3vJ4j6cTj3yTVN99DzEeT6/0g0rzMWyZXZQA7cPztzCbb
   EjZSpc9C5yMGqItA+3Jtnr5+BV7reyEbPjnFxCixI+GNb/WQBtURT16Us
   D7/Dd/XBQ57nq15TtgVGEAxbMA5zWXCYry9S9TwbGJZQNmXefCoID6/UV
   m+xf/6yGcnKeD6QDv+hHKsYYqQWRMA/jQvShOZCMTFBERX1K//gzGNgpz
   iyjx/oda6xPDTTOx0Iw5Ldq7cZDoLRPNdVAHTipN31Z1wTCOTms6JrMm5
   PmRQt9GynJSwcSBaxbDLzdKfvfx7dToFLf1wkwC1epb8U+g18js2VXf7Z
   w==;
X-CSE-ConnectionGUID: n4qsWsl9Sg2NBUXYI9ehcA==
X-CSE-MsgGUID: c6f/pCAvTwy71rMMjy0vMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75930181"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75930181"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 20:51:02 -0700
X-CSE-ConnectionGUID: Y8Xqf03JRwySqeLMsvVxcw==
X-CSE-MsgGUID: RcApLjvmR62YrNpEe39Eiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="222161203"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 20:51:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 20:51:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 20:51:01 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 20:51:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GA979cjtnyfl98gfbY396jeTsANJjJovIOF9IMDM4ih8zDQqaTx+6lfvzW0JNyXK+XdCmr+0xVtjxrqOZR2T0VVB1UQa0PRpw0m/LFkicsr9w9t0olcP+aqV9LOi6S4n2tuueQcq7QriSU8792GxWdFXimwlzD7jRNfFfgNxZ5Td1rUoAUWf/GWoV088BhCsChO0HvceA/zBUPfBJ2YYbV2A9CiwwZ3QuZBaHlgm1cy12PaGp7fC+vNa5T99pS2rrcZHxf6UzY4hYHcwttRd49sUFq7nnlX/0/a0EminN2bhyVHRLo6WLBVubKn9SJGVwfD+0bZLkI5XShD8J0S1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bjzpyw9iF9aHA5WZlHkpJOFI0cKWfY+DDQdcNXFPoDI=;
 b=Pdp9w3vEEZCJ8nJzlE21nYs3K0fEtfmkryuNV+XIMmcSzF/pocXfZ4yjXr48JrnvNqEsuuYqSexZBI/zezqLlGQoiL6FYiENzmS9Jox1f244NMGnrgTb1f2pJgDM1SLxbTKRb2Flcc4H8mX/mx9tzTiBa6TauH3UmMFDA8LhTMb5hYkg0PlzKtuFU8FOjoo4cUWlOPOUHI0SIQ/QH5wvKNLCMl4LytcUeaHMyLE0eiDSgtau24qoWpncPOODOXTkFxaJv7VecpdDWSpx8T8n/MYHb939ym5YaqoWzjFGxrHrgcuuGdmpGgzOvZH+ml41O4v2YOy5JQMN2O25UcYw/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4661.namprd11.prod.outlook.com (2603:10b6:208:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 03:50:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 03:50:58 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2026 20:50:54 -0700
To: Sungwoo Kim <iam@sung-woo.kim>, Dan Williams <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Ben Widawsky
	<bwidawsk@kernel.org>, <daveti@purdue.edu>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Message-ID: <69cc961ef12e8_17890410036@dwillia2-mobl4.notmuch>
In-Reply-To: <CAJNyHpJ41rHOEu+JQZPTBx9ETof9avCBKqStC4zUU_FDz-sf9g@mail.gmail.com>
References: <20260308185958.2453707-2-iam@sung-woo.kim>
 <69b0a0f8bfb0b_213210026@dwillia2-mobl4.notmuch>
 <CAJNyHpJ41rHOEu+JQZPTBx9ETof9avCBKqStC4zUU_FDz-sf9g@mail.gmail.com>
Subject: Re: [PATCH] cxl/region: Fix a race bug in delete_region_store
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR04CA0371.namprd04.prod.outlook.com
 (2603:10b6:303:81::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e81d5b-2474-4127-b5b1-08de8fa1e1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: u6FHu9tjrNa5KI1tZ909CknN5IQ3RKFA4PpfJcGgFVWCJS7P5sajtJ0WJVnGF1alngD6rupWi/5tnjLs+zC3jIPoYodNtslLM3itDeXYf5Ijc85pYp38yERVODMEnFOy1zrxNiNNzpGKZwOO1RRrDOYgomQ9R4Ayv2wKRPef/5oVLCw95yg7Pi8nJfHXQdSxLTnTq4e5Sa4sZILbyY2s03OfM0tbYXYdAmNxks20lC61K+CDFJpSFuOsOe61WSUCAqi3JOzU2CWDY/ssz5HuY/cCqM5m+XNsM/Yn4S9HK9Bz7izLron0W4Fww2K/Hb8ZtAxxO/X6+t7YaoXY+v3nlOjAY9/dQknyZtd/J19A9zMhHJ3WaSyEXp4ktZkTJ+2TBtxHEwiQ4gkn+Qhm5FgXTsc5odsWGoG+XuYTLpXbvcqirVPvS/rYiK7Xgq6SxO3NdoxQ14RhH5hjotoeIv6vD3ic6HzKXnlHgfEQ9clyF+7IKfp6wc8Nzyz9HrBld8vC+m1juTe/UYO6FhV9ZSb0+47j9vUXV8KAsRxBYbMJ/CsAzDv7/Nd4Isf1rJCFhWsc/pvKlXegsMcbJONnN9cxa7C+Wj0xLpMNemEIUmD1tPZxtx+uf/EQEHPJA37jWOUxsDMmomioBEDGo6ToX0z2W+JHrTXqSNRb80l+2S/I/0RANoNviZaLoUcJP8Plldc0sAVJc82SHg70MeopO8qQXllcBXIX5Pxiyj1C3SL4a2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SStOQ2xISGN1eXdXdUVFZW95UysyalRsRVpET0RwUWVVOTZ4cVNUUXVhWFVt?=
 =?utf-8?B?eVRUeWhBMFRkcU5kZlpQS3JQMVdWdzUrcHdEWW9kNnZxSHhDbUFMYktWc1Y4?=
 =?utf-8?B?REZiTmpEd2hwTFRVdkg1dUFHZHlUUlpRckp6MVFlTFlPS2xsZjYxZUsxcllr?=
 =?utf-8?B?M3hsTkJKQWE3Z1dTN1pyTk5VVjdXWk52QW9nazNWazRJYnYwSzd0eG82b1VX?=
 =?utf-8?B?aWdJNklaM2pFcTJTUmZlWWlaWXZnQjhTL3NLVGRpSm5Ec1Y2ekJBa00zWmVH?=
 =?utf-8?B?Tk9qRUFRdnhRbGZROTI2ci92UjA2WTF0TnBFNkNjVWZuWlVtNEJ0QUVvWG9t?=
 =?utf-8?B?RW4rdGtRcjd2bnh6RnBlR3RjcUJ5L29GMGZMU1JvRWFiVmZYTGVRTUVpSjE0?=
 =?utf-8?B?YS9SKzdyQmkvUmd1Z3ptOVJPckMyYkR0SnJuSWtYUTJRR0ZIZGVyRFJ2dFNl?=
 =?utf-8?B?TXQ3OUprSHRCb2NoZVFsSFg3SkJ4OGRzMkNZZnpjMk1LY2JwalFjWDB3VlJX?=
 =?utf-8?B?NXg5aW94V2R4RThJcmYzUUJjMVE1TTRNR2tqQmkrYkxxeXJ2S0pwNkIzemFX?=
 =?utf-8?B?QVJVRUFqTUc0VjNhT3gyZWUxSWFDOHRSZVV4MTVRRkZERi9PWjZ6N1Z3dlRH?=
 =?utf-8?B?dnp4a3RmcnhnUmkyakVRNklCT2YxbGE3Zy9OSW1pOG9XMlVjUDRWRVQ5eDVE?=
 =?utf-8?B?K1dOK0E3aW9yOGJjSyt1OENXdy9OcWNoNU11QXkzR2RRcTNTbW1oY3dGM1g3?=
 =?utf-8?B?OEFadUhvODRnQm5yUGdQU0tITDRzM2lJdzRsejdnazlVck50U2lkdnR2YUx5?=
 =?utf-8?B?dXdacGN2MzZpOXQraWMrQ0U3b0RQNjZLMG9oZkNWUFFvQnB4VjJGZlJCYUJY?=
 =?utf-8?B?bm1obUdjNW1BVnZUdm1GZDlOd1k5SHFPTUNVdDdyVlFkcmNuTCsvSjBTdXdK?=
 =?utf-8?B?QXYxelZDRnJSRXZkUzZBSlQxVmppWGVBdTRkNGhQZmE0RHNYamgxWGFrdGtl?=
 =?utf-8?B?d0dxQTZ4YkRSMUJ4VGdwTzVuL3hJL1NiRVJmMEFKbGFKQXo4V3RqZDVBcXFY?=
 =?utf-8?B?R0ZGRTFOREpXRzFidjFuMjNMYy9Qc1JWV01SK1pNaG1xTlRNQTEzdHhGZ1d4?=
 =?utf-8?B?Lyt6VWdKMG1VakVsTjdZL1RDajB6ZHk3NUJtVEZwV28wNDJCZHg2TWdPRlkr?=
 =?utf-8?B?MkdkV0lMVGs3eE5QMDhOaUNiSWpUOEpkTXdQUWYyMzdCSXFVaDMxdHovTnR2?=
 =?utf-8?B?OGFZdmI3aXlmekZ6NHhWTFVoMzFOcFp6VW5IUkU4OTg5RUR6dzdvWTkzYjIz?=
 =?utf-8?B?WHlrRGd2Q3lzMHNNY2JKeUtxZVpuVGNGYXFGOTZpTWRvWGJiVGZvQ2pwSHdI?=
 =?utf-8?B?QjlRakNWM3ZjL2F4M3Zwb2pxdndGK0dzMkUxYXRScmx6cWdoUElGTnAzNWVD?=
 =?utf-8?B?TDZad2hmWmhOaE5rYldNZm1xanUrQmJwc3VuSDJxWEdKWUprOVhZZWg1TG9x?=
 =?utf-8?B?T3Q4ZnJENHVRb01YZ3hMaURGN3NzNjlEM09JcEZpRGJ6ajFVZmFJWFNqRUtD?=
 =?utf-8?B?M3l1blVsMitRNlJjVHIwNkM3YXYwd00yWU9KOGE1YmRFMURWaWI1eGNmSmNQ?=
 =?utf-8?B?TWdpNWhCTWM0dzJLVXVhMXZDWFhEbS9Rb0kvR2pDWTRpaWxqRDFMalFLT2Fz?=
 =?utf-8?B?Zm9tbGErYU5sZ3ljVWhQczhlS3REUGF1eXd4bUduOEllLzhHdCtoL1A5K2hR?=
 =?utf-8?B?WVdkWm5VSkhuMmVRWU5lK0hmSnJBVmR5UmpQbGl5aEVlNUZYbzREOGJqM3Y5?=
 =?utf-8?B?ZDRRTmZsWW1MSDBtQ04vWXM0OEEvaDl3VGpLMjVhZTVrREZ3cUViazhob0R1?=
 =?utf-8?B?bUZZcUcybGJnNGFJeUxWRzAyUHNJU2dJa0p1QktZbWxFTjY4RE9KS2g5UmJh?=
 =?utf-8?B?VjVlc3A0ZWIyK1gyaG5KdkpLdnZtZUxKbFVGU0hURUk0MHJ0VkhPRkFTQWxB?=
 =?utf-8?B?bjVLQnJyeGN2R3dRYnNwQkJGQlpGSEE0aWcwMFFKQ2RUNWUxeGRMMnlJMnp4?=
 =?utf-8?B?RG1NdDcxaTdWcUUrTHdvaVU0cFRlc1FscWIva3lOa0VVeU5nQ05NKzJXdlZw?=
 =?utf-8?B?Z1ZtWE1LME5HWmREN1U5TGVHUElaTnlNMTBDbFVyUjg5dk10dlFvbmQramRZ?=
 =?utf-8?B?KzhDVzRvajZFNUJJTStPbVNSVDd6NDBudjdNR0VhSFRzNmppSjRETm0xN0tG?=
 =?utf-8?B?MlAvbS9oVjlkeVlkL1dtbFBtMlNCcy8raVhyZERPclVvSGZ0RHRxWTlXcXJn?=
 =?utf-8?B?Z3IyUlk4TDhaVXdPcUI3bXZOWUtKVE9uRDM5MXo1V1N2azdMbXFYQWRHOEgr?=
 =?utf-8?Q?ymH959UIUSE9Gh/s=3D?=
X-Exchange-RoutingPolicyChecked: OLwo5L79Ub8uIsNkFhYku2jVPek5JjxugyGUgVRA7nQ1yQcovJuToj7+9lqhhqSLCtRjQjg8cHSBskmUzfgAK0l04dyp36phB4jLtfHmd1Yftj4n2xyTcasMRQPRxGHhuCvs2tDAbhpIV0Y5cJzSqC+kLkUHn/oi45Uj9DuoAWFQt0J+XHljmXlcvlSbjb9lRpHxhzNVLLCqrb8mOeHuZ2gi40vZOwNOCXYSenWOGqBr4z7G0jAxHhZHu5HIX70Jxr4B2+bEzpZ4OfGuyUhZY5DEm4tyr4nItkYCY2mzQ3g2YyUiGxgqcctIPZGGd0aBDoSDYsCU20+S9GaoslfDog==
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e81d5b-2474-4127-b5b1-08de8fa1e1fb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 03:50:57.9316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRJtMYJmm7vXHhtqf8ddCBDswjG8nbUKgni3uICz0HI+EnWo5ab4xfZm32bJXo3WLuBAKiw/ZXgbiSmAZoC6o8HbUJjG2E1twsyB4fg4YkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4661
X-OriginatorOrg: intel.com

Sungwoo Kim wrote:
> On Tue, Mar 10, 2026 at 6:54=E2=80=AFPM Dan Williams <dan.j.williams@inte=
l.com> wrote:
> >
> > Sungwoo Kim wrote:
> > > Fix this by replacing devm_release_action() with devm_remove_action_n=
owarn()
> > > followed by a manual call to unregister_region(). devm_remove_action_=
nowarn()
> > > removes the devres tracking entry and returns an error code.
> >
> > No, that is not an acceptable or comprehensive fix. A subsystem should
> > never try to double unregister a device. Keep in mind the decoder sysfs
> > stays alive while the devres_release_all() actions are running for
> > port->uport_dev.  As a result, yes, Davidlohr is right. You can
> > theoretically observe the unregister_region() release action firing
> > while delete_region_store() is running.
>=20
> I appreciate your review and suggestion of a new patch. It seems more
> complicated than I expected!

Yes, the CXL subsystem is unfortunately... complicated.

> I'm new to CXL and device drivers, so I would like to confirm that my
> understanding is correct.
> - CXL tolpology could be: [upstream] host -> switch(s) -> endpoints(s)
> [downstream].
> - The host can configure a unique address range (=3D region) to access
> each device.
> - The bug happened because releasing the same regions can race.
> - Although the prior patch handled this, it's insufficient because it
> can also race with releasing the device (what Davidlohr had reported).

The patch was technically correct but it relies on a design that
requires depending on a double free semantic. Apparently Rust needs it
to enforce a higher level semantic, but in C we need to handle that
semantic directly.

> > The only comprehensive fix I currently see to that problem is to indeed
> > get it back synchronized under the device lock. This prevents multiple
> > requesters from colliding, and from devres_release_all() deleting an
> > action that delete_region_store() already committed to handling.
> >
> > This looks something like schedule the devres action to be released in
> > workqueue under guard(device)(&port->udev).
>=20
> I assume you meant guard(device)(port->uport_dev).

Correct. When I say "something like" it almost always means "be careful
what I am about to say is full of bugs" so, good catch.

> > It is ugly, but it may be the case that this wants to synchronously
> > delete the region, and asynchronously cleanup the release action.
> >
> > I.e. unregister_region() grows a new:
> >
> >         if (!test_and_set_bit(CXL_REGION_F_DELETE, ...)
> >
> > ...flag to enforce only one path successfully deletes.
> > delete_region_store() calls unregister_region() directly. Then the
>=20
> To fix this, you suggested:
> - Add a flag to make unregister_region() idempotent.
> - Make delete_region_store() call unregister_region() directly.
>=20
> Now unregister_region() is race-free. But we need to release an action.
>=20
> > workqueue's job is to trigger the release action under the lock only if
> > port->uport_dev is still driver-attached by the time the workqueue runs=
.
> >
>=20
> What I'm missing is this part.
> How could asynchronous cleanup solve the race? In the worst case, the
> workqueue could start immediately after we schedule it. In this case,
> it's the same as the synchronous execution.

Asynchronous cleanup gets us into a context where we are safe to acquire
locks. delete_region_store can not hold guard(device)(port->uport_dev).
You can try it to see the full lockdep splat. It is setup by fact that
unregistering the root decoders is performed under that lock.
Unregistering root decoder flushes userspace out of sysfs attribute
handlers. If those are holding the lock themselves it is an ABBA
deadlock.

I circled back to this because the CXL accelerator patches also have a
reason to autocleanup regions so this would be another source of
cxl_region deletion to rendezvous.=
