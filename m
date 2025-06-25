Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CAC25A33F
	for <linux-cxl@vger.kernel.org>; Wed, 25 Jun 2025 23:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892771; cv=fail; b=ng9bvD/CQnq6G56TOYMTl2HxGopMeeLIj4HduWY4xRBqisIJfSTUIqydC2uPsT2+Q+c034AsaHrj2fQbi5t1yk/HV0kG9ufKbDgBHTIbXNR+h+uebaTg1KVzpykTeZ3nNO7DeP0gKUBDEiWJFm/jMHozk7ac48j71zvtR6G77hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892771; c=relaxed/simple;
	bh=Vq7lGGzYwUimf617KTkKzAtMJe5WQiA2IydmBEU+tlU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=dSIGy8qqpL2m8p13baDwmRQrnWYcSqh7Mbet12/QzVQxd7XvS5qSfB3piD73qlMyj46JdNIqVyq/vNP73VYyZQRtHRmggPKJxzMGtpbXhj33LezTU9N/2lFRuPJnSqABNcGEfS/8LKMclGYuBEKqZKN8hPdU30TWcoFgfSehwRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/qefquq; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/qefquq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750892768; x=1782428768;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Vq7lGGzYwUimf617KTkKzAtMJe5WQiA2IydmBEU+tlU=;
  b=P/qefquqeHRN1A/i3N8W4kn78mMACkpaFQuoEuGS2ZZbq+WXjlbrIRWK
   H5sXhcQpgDxCWLyqHSSOW1FOwKPxQ5mC7EgJVCPnTncEW8TUzLd2raaBu
   WNb25cwd71DTN4zhGQf/TThB4jfkV8h6AwEqgMxmEcgO53MUgZwTJD7QS
   kI4+xo8Dp9YyPOk23foJYG/sWXrHcFxYLQDeKeCDBf8Pq+WZG1S/j5YDG
   JmHYeGH2xNyWPvIPV6CeX6z54AJuRsmBsYnvkPqzY227WU4d3f2og+ugX
   UD7PzN7NWCRrmctE/H50P1LccDifyDTVZiEBABAUlHzxa66PIZy0eG23g
   Q==;
X-CSE-ConnectionGUID: yn5hm3NYTraW5bCuXG2liQ==
X-CSE-MsgGUID: nxxa6cBnQayxURmUfMOP5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53246094"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="53246094"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 16:06:07 -0700
X-CSE-ConnectionGUID: hj5FdVV1SO6jd5y+5Ye33w==
X-CSE-MsgGUID: eqa5BB14SqO8iXKLkIbdiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="151871232"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 16:06:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 16:06:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 16:06:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.79) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 16:06:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcVk5K9bNCnY5agQYk5dNxHUmRywIImAHcg5DVogAAl0A+KmGQvbgFTOAAbTUKCmbP+DKTivHNla7u8f6ANNFkI4yCeAbj11nojewfUlp36fpIWkMZPtkBhS9mOIn+rqyEFXYgLOnZS43zsk9FSBZtR0IYOKC3ht5+MEW2J7PnSFi2e7pd2GlYK8W2jv8ozsjiyw9jzSGD1/lVaSZV6SPqdOt5/OGJ42sayEQhzC1WAsjZt6jZn2d3qS6f4amzyCeNiA4COox2pgIan+TV885AeC1GrWJwzcVLh5llEli+G45lEHN/5LLShT2zFCkyRabuGG0A1iJlRJTYU5XEWq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UGX8y30iuI4ahSmXG6MonwruYzHZxQDT195wZxKNWc=;
 b=ABvFY69pZpGq72fdEciWkZiQCvu9eaFSnzzDAunKLOoWZgdGOtwEHlyFWy7+16sKrD4JHW3wFmVrbe0CqVZL5EqvXkVsSGV87Y6oeSM0JTxSAWgP2Z+Pv6YS7NoiwQi1FtLZ8DToO/cbumfllyBoMKEZ8ZAcW+Jl0+01UYWAVeOG7+bYk5MOUJ3o68ghHELDkp463THJPpsNAivEze26xvfHZQl9ZON4gXz3gZ9cQPyFAumSZkl7MYuEsKwnrcKBiBQOSBHJoZkdI8uSiW/3c6FkouBhjtZwr2wMBarlL94+hC+s9QqYf9JyERoYE+Du62aUMbvOLRidiw3JcesbEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB8062.namprd11.prod.outlook.com (2603:10b6:510:251::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 23:05:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8857.025; Wed, 25 Jun 2025
 23:05:36 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 25 Jun 2025 16:05:35 -0700
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Message-ID: <685c80bf237b2_23a2a100bb@dwillia2-mobl4.notmuch>
In-Reply-To: <50bd42e0db1ed5979a00e6f5a43147320a1d5b9b.1750725512.git.alison.schofield@intel.com>
References: <cover.1750725512.git.alison.schofield@intel.com>
 <50bd42e0db1ed5979a00e6f5a43147320a1d5b9b.1750725512.git.alison.schofield@intel.com>
Subject: Re: [PATCH 3/3] cxl/region: Add inject and clear poison by HPA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b3cc42-9f30-467f-51eb-08ddb43ccbc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tkh5YysrRGVFYnZkRjFKZnd5Zm1HZHVLU2tJK0tSbXRSVFRZNGc3ak9TNGcw?=
 =?utf-8?B?dUw1bllDcmlxWDhhY1FOUWcya3VmNFRibGhza2dxa0RYb3RWY0NLdzNKR3Jo?=
 =?utf-8?B?THp5VndUSEZlcFQ4dzN5cExYY2NWY3VuNmNYbmkxSFp3eDdpUGFKY2o5QUx6?=
 =?utf-8?B?Z0kwNDFBNVVlZ3FDZ1pGd2hRdUdhTjlJNkJEbmZNRjN0QzR1OUFsdUUzU1Jl?=
 =?utf-8?B?V05Od3ZNRC9JN2kyaGtMcURERmhSRGk3ZERsZU9PWkRmNGRhWU1xTW5Day9z?=
 =?utf-8?B?K2xVQkRPbjB2UEU2UHNZS3NuL1ZIRERpVC9aVHQ1Z1FIejNDQnRjKzhMTll2?=
 =?utf-8?B?d0VHV0dsL1pCSnFVMzVmbEZnNi92Rm9GTXYvOSsrUEw1aWoxZGp2Qk95TEpC?=
 =?utf-8?B?cFowVlEwUlI3enJFL0pOdGVMc2V1WGNkMyttVzNSSlRmSTd4eWgzT09oVUdJ?=
 =?utf-8?B?MCtPYXUvUlQ1Y1hhOWJZRzliRjVqV2QrTnk3VlZlM2ViOHIzaVZqcnY5aUky?=
 =?utf-8?B?Sk8rUVZJUWVkV2MvMXN3b1FMS09EUWxCMEtPWEZQM1lGSWdFUzVGbWwzZUdE?=
 =?utf-8?B?eDFOdTdYdDJ4eUpIcGNnY1hHTFhmOHFnbzZPYTZFZytvWENQdzE4QnlxVGpy?=
 =?utf-8?B?VmtRdmZRZ0dBTVFPVjZ4Z3F2OVlSM09ZV0lPR2xmZ2pIWkxOdWtQNGd1YktU?=
 =?utf-8?B?K0RIMjZyUTV5TGFqYlVlNW1jY1hoRlRRVnZFUHpOUkUwNjg1NHp2eHFoZmRO?=
 =?utf-8?B?QndkSnBSN3dQL0Y2aUFUdUdhRk5jd0Robk5abkR3S25tRlIyWkFyRk9qN1RF?=
 =?utf-8?B?bGkwTFBrZnNBQ2p3OGZJMUl1OGNLTWNCTExUakRENW1qOVcxdmtDRk5Yb0R2?=
 =?utf-8?B?T0dHbEZiVy9tRkdleE1NOEMza1RrTVR5S2wzVGc1K1cvZGE0Umx1Vnd5WFlM?=
 =?utf-8?B?QWxzQTllQzZ3bW9DbHRiaXNWOTh4SVZYaHJlZjhoaE5BalE4OU4vYUZQb09L?=
 =?utf-8?B?aG5BYkZNcGluV1FjeW9WY1VBbXBzZ0pzRmxMbUVNejl6UDZ3Rm1IQnNYYkJN?=
 =?utf-8?B?RFZLYkwyY2FGOWhuVGFzZFo5ZGhxbFhQVEpERHpQSm9aWFpuSE15TGlmaGsz?=
 =?utf-8?B?VWJpaEplelVMSVlUd2pUSEZESkJjWUxqVnRJRzA3SmR5YnphanlOUThhQ2Ny?=
 =?utf-8?B?dkU2YmU5eU5pU0UveEVYNElvRERvZVdlK2FhNzBDWDFIZXlwZEZQa2FlNDBO?=
 =?utf-8?B?QUkxcGJpZ3Q5cDJEWUlJOGZPdEtETXNNNG53Zms2OVhiSmRyTWJlVkhnUG5k?=
 =?utf-8?B?ZCtSREYyd1lxZk9iV3lvMWpIVDRSdVdJWXN0U2FmQTA0cEZyalh5RHdyekFI?=
 =?utf-8?B?eHRsZkVMQ1FPVWFQTW9JY2hvbFhRWVllY0FGSGUzOEtRalBzeUVFMlJVL20z?=
 =?utf-8?B?V0NGMjVsUDlTeUFXM3RXTjhzaW5RN1Rtck9hb0U0YkFFb2VHRkRudFhqNHFG?=
 =?utf-8?B?SE9WOXNqKzd3dUpGNE1qRVV2N1dSTU4xRndiTDhOUDl2a1lXTGRTRjZ4OXhr?=
 =?utf-8?B?TTBuWjFPMTdsN2tITEtnZCtiVWlubzlMeTdTb2p0NmJSOEVsRGozaVVMOE9i?=
 =?utf-8?B?KzJYS3FJQmZ2M2RuYzc3ajJKTFlkMS8va0hWU1dvdDBSMWcweDRMakVXWGVM?=
 =?utf-8?B?K25CWkNyczJJVVJKR2EwODRSamhuQ1JoYnFvUStaczdrck0rWkpVaDgzc0NR?=
 =?utf-8?B?TTlwY0Erb0RWQnBqZGNQQy9Ja0dHNGFiT3M1WEMwN0Nzenk1UlgyTGhYaGRr?=
 =?utf-8?B?Qk82MXhSWFZXUXdpaFRZVTQ5VjJoZkJYVWdueEZMeUNwamdUdGR5WWFZRHlR?=
 =?utf-8?B?NWFHRW5BaDRRcVg3V0s5ZXlZdVViV2pCc1M0QitlaEVQOEQzZkpzOTdzbEk1?=
 =?utf-8?Q?sNX1O/SJ2oQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnpsUml1REUwN0dGMHp4SkZLK3ZCT1ROb2ZFNFdQUHJoVEZ5K1BJbHNOamFS?=
 =?utf-8?B?Q0pSZjlGRlE4ZG1sbWVIOWlyS2lWV2d0YS84ajMzYTVXUGFuZklPL3hWdTZU?=
 =?utf-8?B?ZGRBU3RTMDF5R0pLaysvTWRObWV4Snk2WXJxWXNPdklxdTd2aDVZWE13S2Ni?=
 =?utf-8?B?VTE1U3g2WVFTblNTT1RUMWMzL0pRY0ZtamM1WjBqV3dhMWVVMGFSMVNyYjJZ?=
 =?utf-8?B?S2poYmFSdHM5Q2lQVzRtN09JaEl2R1FyUUd1RGNSNmNFYjBubUtEa3Z1R25X?=
 =?utf-8?B?M2dLd2RYNDlxdTZ4K05QdTZ2U1N1OU9XR2NLZWNsbXJtckx4elVWWHRFMlFa?=
 =?utf-8?B?UjJwNnk2SE9CN2FOekthKytnZkVqUko0cE5SaW1TQmhweGhqN2J3VGR4bGo3?=
 =?utf-8?B?ZFNjMFEzL0RZcGVtN3UxYjRIa0pqeUp1MXpvaTlOV0hGMk5OMFJNaHJsTUxE?=
 =?utf-8?B?TDJ3Nm5oWi9qNjUzejhFWjQ4Zi9xalpYeklBTjNkQTZKbDVESm56amNmSm9y?=
 =?utf-8?B?ZS9mUzBETzJ3dHVqbzd5T1V1bWNaRkFMZHJUdmJqVi83eXowcTVGUSt6VUls?=
 =?utf-8?B?SVZsWTh5OS9hUG4wTFVoSHFPQ25TSE1pWVNGcjdUR2ZSM2ZpOUM5VUVmOUV6?=
 =?utf-8?B?aXZoeUtZT1FBVnFRbWpBNGFub1ZNbmIwUzdReTZVbDFoYlZ2VWhUVEU2V0tP?=
 =?utf-8?B?RU4ydFY5bW9RTnJ0K05nLzBuWlB5emtsalFkSG0yanFDMjNsUDMxc2RIRkVK?=
 =?utf-8?B?eUZYdktCZjFsSzJPK0xsN2p3bjRvc01UNXdvUDBCa29ndVdnRXdRczBwSkRn?=
 =?utf-8?B?QisyZ0VCbktQUmNvVUljSHdRMVllaDdRQ2RZQTBXbFZSd3o0MHpoTEw5Wm1R?=
 =?utf-8?B?eEN6QnlVdy9tR1RpeS9XMzVwZERkTzNhelZ0OVZvMmJ5MDBZRW5wM0dSS3RW?=
 =?utf-8?B?N2V3VjRsTmZ0NkxUcVZzS0tVNEN6Y2FPd0RhYlE3WGdPaVd4K1F1eUNTSXln?=
 =?utf-8?B?MXBIYk85a3N1bktLZFFJOEtZSk9BN3AwWUxYdnpEM0dxNmNVOG5nMUltaU4w?=
 =?utf-8?B?dU1BbTAza05xV3R3Q3FmbkdRSlI1c3J3SXZGbVBFL0dqbWJVd2dPMXZMQUhh?=
 =?utf-8?B?WlV6ZWR5RG5JNjlYM2R6VFh1RlBmVVBYNUV3L1dQSzNlcDdKdGhHRm5nWlNG?=
 =?utf-8?B?TVpBSDRrK2FlbFAvRHRBN05PU0VaTWc4cVgxejlvdnVwdmNJSW8yMFhCRWNS?=
 =?utf-8?B?Y3VlUVR4ZWZaT2ZiZXduZCtlZWF3eHVFOWdUcloyTEcwWHhBaXA2WFlZaTd2?=
 =?utf-8?B?L3V1OGZhdm45SzNjTkwwNWpxeHd6ZTFIMEtlVzRRbnBzYlFaQkF4eXZ3bFZQ?=
 =?utf-8?B?eU1Hai9vVUJFczNmNTM3dEJid2ZRaTZaU0krL3dBeCtVYkk3Y0VrakNVdWY2?=
 =?utf-8?B?bWt5eWl4VkU0SExCcUpJeERrd2grcVhSWXVieHRTRVhyK3hlRS9tR2pYblJs?=
 =?utf-8?B?czF5cFVaanBqSlY0d3UwVXppa3QzRGIrRkxISzJvQzJWMzJBUzZSOHphcDJG?=
 =?utf-8?B?M1pGbFlIUlNxZnVtc2YzYlVCOWNGOXZmVUFLL0xaWTUvbUxMRWRURTR0b3hu?=
 =?utf-8?B?TFd6UXRuNE5BKzF2b3RWQ1ZHcUxKYnlvRy9KYTVzZ2x1TGZJcVNuWjdqT3Vo?=
 =?utf-8?B?Zisra2FjT0tKVHFBdW9HOHdPeEc0MEJqSnhTWXExNFVpQ1AyRHNjTXdUT2pk?=
 =?utf-8?B?bkhqaVNzZjBlVHd6aTQzOGhXYytXcWxBUVBJNDNNUTNmMTBOZG9XdzJyM2dV?=
 =?utf-8?B?Rkw2azhtK1BpR0tYd0NvdVJIc2lWQm5iT1pWWVNwVG9GaW0yZUhlenNHaTEv?=
 =?utf-8?B?MDhNMmU1Y2FhN29yOHBCSkl6Mml6emxNbWlKa3dEd2JuL2tpa3RIOU54L3Vt?=
 =?utf-8?B?VTVWSUhDNUV5c2xYeHpnaFhVRzIyajZvM1lqNER5bzhBaEJmaWpTN3VEc1dV?=
 =?utf-8?B?Z1dHTERNK0x6YXNJaWdXK1ZlVjlzc1B1a0dmQWV3TzIwM1FuM1pIblBlUW1p?=
 =?utf-8?B?S0VlNHRwaVFva1NrVStZZjFLT0xtMU0yRk43eFhzbi9Mc04xVGNqVEFNTmtS?=
 =?utf-8?B?d2Y2TTl3Q0MydWFObHNHSGgyNHVhelR3MzB4WmlFK0N4ZUpOa1pzNEJEQU1k?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b3cc42-9f30-467f-51eb-08ddb43ccbc6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 23:05:36.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBbk4PnsX2/+bG0uF7ygGc0I/68vFP0s0Wl/GK81VL/FGxzfDEh4DhMJnblLqlA7uKJH18qiReo6ouz5+1Py6qS3YFFTIkMXx2K7Hkrftms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8062
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add CXL region debugfs attributes to inject and clear poison based
> on Host Physical Addresses (HPA). These new interfaces allow users
> to operate on poison at the region level without needing to resolve
> Device Physical Addresses (DPA) or target individual memdevs.
> 
> The implementation leverages an internal HPA-to-DPA helper, which
> applies decoder interleave logic, including XOR-based address decoding
> when applicable. Note that XOR decodes rely on driver internal xormaps
> which are not exposed to userspace. So, this support is not only a
> simplification of poison operations that could be done using existing
> per memdev operations, but also it enables the functionality for XOR
> interleaved regions for the first time.
> 
> The new debugfs attributes are added under /sys/kernel/debug/regionX/:
> inject_poison and clear_poison. These are only exposed if all memdevs
> participating in the region support both inject and clear commands,
> ensuring consistent and reliable behavior across multi-device regions.
> 
> If tracing is enabled, these operations are logged as cxl_poison
> events in /sys/kernel/tracing/trace.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  Documentation/ABI/testing/debugfs-cxl |  33 +++++++
>  drivers/cxl/core/core.h               |   4 +
>  drivers/cxl/core/memdev.c             |  11 +++
>  drivers/cxl/core/region.c             | 120 +++++++++++++++++++++++++-
>  4 files changed, 166 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
> index 12488c14be64..c784885cdf07 100644
> --- a/Documentation/ABI/testing/debugfs-cxl
> +++ b/Documentation/ABI/testing/debugfs-cxl
> @@ -35,6 +35,39 @@ Description:
>  		The clear_poison attribute is only visible for devices
>  		supporting the capability.
>  
> +
> +What:		/sys/kernel/debug/regionX/inject_poison
> +Date:		August, 2025
> +KernelVersion:	v6.17

I do not find the KernelVersion line all that useful because git blame
can get you that and sometimes the merged kernel version changes.

> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a Host Physical Address (HPA) is written to this
> +		attribute, the region driver translates it to a Device
> +		Physical Address (DPA) and identifies the corresponding
> +		memdev. It then sends an inject poison command to that memdev
> +		at the translated DPA. Refer to the memdev ABI entry at:
> +		/sys/kernel/debug/cxl/memX/inject_poison for the detailed
> +		behavior. This attribute is only visible if all memdevs
> +		participating in the region support both inject and clear
> +		poison commands.
> +
> +
> +What:		/sys/kernel/debug/regionX/clear_poison
> +Date:		August, 2025
> +KernelVersion:	v6.17
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a Host Physical Address (HPA) is written to this
> +		attribute, the region driver translates it to a Device
> +		Physical Address (DPA) and identifies the corresponding
> +		memdev. It then sends a clear poison command to that memdev
> +		at the translated DPA. Refer to the memdev ABI entry at:
> +		/sys/kernel/debug/cxl/memX/clear_poison for the detailed
> +		behavior. This attribute is only visible if all memdevs
> +		participating in the region support both inject and clear
> +		poison commands.

A few food for thought comments here:

In the nvdimm subsystem all of the poison addressing is object relative.
I.e. instead of absolute HPA it would be a 0-based region offset. That
might help when we get to platforms that have additional Host Bridge
translation because HPA != SPA in all cases. The existing DPA interface
for memX injection just happens to comply because DPA is 0-based
mem-object relative address. Lets use region-offset values for this new
capability.

This documentation probably needs to be clearer about the data loss
danger here especially when this error inject can permanently destroy
data in the case of CXL PMEM, and crash kernels if this is just memory.
Again, nvdimm was careful to separate "uninject" from "data
repair/recovery" because they are not equivalent. The documentation can
note that this interface is test-only not repair
