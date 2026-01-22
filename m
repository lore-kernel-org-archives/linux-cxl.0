Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F0333D513
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118987; cv=fail; b=aPsAloGYP0AP+ieJrrDKlnvTrd2zQLWWAnPs557KY55ehCs35SZTTWpVUmUXVA7DB+32AlTeXIdQoQgWpFW1t1zH3wOOqMLVhd/uxORyFWg8/9dQpZo/JcnNMxXlsoCuFnxkIcr2J3SHNoDqclrhMKZLi47RZUfF+sNReX9JAs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118987; c=relaxed/simple;
	bh=wDk1P899wb9yUSl6CyVD4S2j+YyorqDqCn4a5P3vYis=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=j3dJm2IKQtXDs0NYqLmOB5qdmFRMwrooRQHnjEuhXATkFuniQ4B4T8X+VF4J8Xw8vQ6ZyEGLj9IcWQ2dZw3UQLEhgbY5iQGNAjZt4jQ2K4XL5cLWGtqly5QjaPCMGtXNm6L+uGN6V7Zb5gz93UluWFB2OFt8GJ2TGCLwBElOcFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeF5yrZ9; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeF5yrZ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769118983; x=1800654983;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=wDk1P899wb9yUSl6CyVD4S2j+YyorqDqCn4a5P3vYis=;
  b=IeF5yrZ9hzVRN/8WT6qvC0rB2vZHhXNEMFwt/g87jcpkl5hM7mXpHGT1
   xW1YknxkhBaGGiQExx7St610xaA6ILTcGrQ9f5MGIAHkX1eN3DCb+6YAN
   tUBQVqKicQiH3JrRG+WePHsPVkJd/wulKb667F2gOSgoeQiOaOjrVAuvv
   tjnGlzkPTKaOs2yFM25aJmdJNQz3Tyz4Us+SVGwINzbX96J+4oKKq7rNB
   kLyw2uVqs6XQdxIIomqg80byo/ZXSo+PO2DlOEQldkPW8lQDQCN5yTmWV
   SY3pywwXsUwFE8K2X3laGKJ6U/qFj4nGjDyvaSUCdqS0d2xP25z8ZbKhm
   Q==;
X-CSE-ConnectionGUID: vCZxkDrGTDqW9F7MR7FA4Q==
X-CSE-MsgGUID: xehMEXfrQIuJBCFHxcW6Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70420764"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70420764"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 13:56:18 -0800
X-CSE-ConnectionGUID: gyTWVCkwTdqiwcnteur+Gg==
X-CSE-MsgGUID: m6QlzltfSLCOsq2K4xOKBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="244456982"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 13:56:17 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 13:56:16 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 13:56:16 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 13:56:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsb+BozV2n+cDYYZMy4WxInglFfSrZz7mBsWzaAdTpQxQ3RhXOcPl6Xb6rUdmmvJg80kedsRBD4qpFVv56Xre4ouzMIzcckHy2cf7g5m2PysgVHA5Q022jrxctkEHpgM4hcG2pBc2WLgRRifybdoin6cspqssIbPrA+/xOf/crmpleMpXqgQKmqWZwjbYZ9pkWdu6IU4nsFfH7thsmbBW5oT+lBOBWcvQC8GZoO/J4Gx0LPKzAXYQimE8MmqeCA3NxivOmiBoemxvKYxAurQcCKzD1tRf32wEnG2OFfgw1LFbAMXIv150iDgGBTQLRRi0THxu7aj9kocSKe+ymIZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkok81ApdiewmIrRuFW1mgDwRJ1E2i6bWnL4GyzPceg=;
 b=tRrTbkS0IsfWWBvlkFwzdnHiUGUSYLtUuBfruaoYzd5q3cJuBwuYWg9Oq3fIVPpdah2l+NUvpnCRNVuWpUL2pEqWRgEfxB0ha8O8bM4kgKHD2Y1vgG/5xnHzPGi7B3F8vGsZgguPyh/WzE+ibMmrbfhNKkCJNMA794PienIYl7nsF87qXzfe/aWhUKn+NvWnys6hCsG8gDRyhi6lGkw4w2rtaqikSxFAE25o+5btF5NXK81dzy6zJY6Q/DrzLOxzw6S281xB7oa1diwC6Qojkt7KfRhDC9WLRzG8dXONMDwLYsTOe7vPI6IRSelRBhqURaQZh/KMW+UFV6TzZZdwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6014.namprd11.prod.outlook.com (2603:10b6:8:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 21:56:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 21:56:10 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 13:56:08 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Message-ID: <69729cf8b1f12_309510043@dwillia2-mobl4.notmuch>
In-Reply-To: <20260122150054.00006604@huawei.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
 <20260122033330.1622168-7-dan.j.williams@intel.com>
 <20260122150054.00006604@huawei.com>
Subject: Re: [PATCH 6/9] cxl/port: Move dport RAS setup to dport add time
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0208.namprd05.prod.outlook.com
 (2603:10b6:a03:330::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d111d35-2a13-4e8c-666a-08de5a010dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dCsyZXo1RVZ5eVdmTEtlei8wbjhJdTdkY21VY3d2V0o4VXhHd3Z4WXRnMkhC?=
 =?utf-8?B?L28wT2twYk9pdEhBMDZJSDhXWFdaMnMrUkNaaEY5RldYck5BZER0RFB0eVli?=
 =?utf-8?B?Vmw2QzFpVmhMTzl4NzRyQWs3TXlMZm84SWRtYldiNU5leWhVR1ExM3o0c3Fs?=
 =?utf-8?B?TFVwWWZvRVZaaWtHY3FTblBmK05DWUxPVzdJSm9lT2FhbEtqY1FXbmZmYnhl?=
 =?utf-8?B?dWZYa2dXNE9uZis1eVhyMFZjRWltKzNVMG9UNFUvd1VzN3V5cnIrcHNjdUtt?=
 =?utf-8?B?NURyZ09LSHdqVjJJUDlnZEVVc0paSmpab3hkTnFmQ01ERjE4ejFNdTdNaEtq?=
 =?utf-8?B?bUFRKzlsQjdvdXRIR1k4aHVLZDZsQmtzTEZKRGw3clkwWTVEV00ySDZuSjZH?=
 =?utf-8?B?SjRPdGNpTjR0V3JxRFZKQUpLeEVLZkJ6R293akU5Q0RxVUczVGtBYjJ4OFU1?=
 =?utf-8?B?ZnJyd3RGY1dqZ1o1NWtsQm1lMzQvWTZsdHo1U2ZhSk1nZFhYb3BYV2RjL2JJ?=
 =?utf-8?B?SUhLdHo2RHpQUzJDWHk1UFU3ZUxZc3VrdGlrc0JZNVFabDlaZVFiVWM0UFd4?=
 =?utf-8?B?bWxuSEVOK0MzQXZ6NzdZdUQvSkhPcEozTUE0YmkxbUpxenM5cTZKRXljbXVw?=
 =?utf-8?B?Zk9VeEZiWmNiUFlJUlcrT1E1M2d1QVlHY1doRlNqU2F3TEllRjV2OXVCVWNI?=
 =?utf-8?B?VDk5SEkwTTFiaDIyUEdMS0FpSmh6aTJYM3EvYmNwK2RIL0hyQWRoZzFXUWpz?=
 =?utf-8?B?bTI0Ym9rUTN1STkzdUdacG83cThVL0lRN0E3anl2NkFaUytzRytKM21iK2k2?=
 =?utf-8?B?ZVduNzRCclFhQzlBTTY3UkZ5TmhYSXpNMXBPSHU5N0ordDJvVGxFN2dja1dl?=
 =?utf-8?B?MXFLRHo5RTBTWCtUVXRaRUdEcEZJbTBCQ29mU0VoVnlTTU9sWmZBdDZPamo1?=
 =?utf-8?B?QW1CSG44enBxN0d6Nk02QlR3bFZCN0JRTThUeEg3MXFDd0ZFemZSaHBlT3VX?=
 =?utf-8?B?ZW9CdjlVKzFqeW9MVDVFNnZxLzZkeW51dythcHkzVUJ4WFduTE1rb0lGUDVo?=
 =?utf-8?B?MjVIakhhelc3TTNIOHNRdDdOcG80Q3I0RWFTN05mWS90V3JaMFpNTHpDeklz?=
 =?utf-8?B?VmttZ1J2YkdLRksyaStHcTBoNlo2YkxLZDIxWG1UQkJuc3FEbWxPVUs4QUY0?=
 =?utf-8?B?RjNRN3NaaTdyWlBqTkhNbklxZG9xVWhSZTVYMk1FVE5kcnVRNStrdHVic3VZ?=
 =?utf-8?B?NldaVjNtdWN2ZmwwcVlyUEw4VVpFcXFTKys0ZTR5WUpqbkxjMEZnUldOeGpD?=
 =?utf-8?B?ZWJLQWZKNGppZnJNaWNNUTY1THBGTkZMMXM1cTN2N24wUHBBNHQ2OFM4eHNX?=
 =?utf-8?B?Z2JSRTFZNDlMY0J2YjhvQXB3dmVNWkQ1aGlEQU1IamswbzEzUmY4MmMvaE5F?=
 =?utf-8?B?Tm56dWpTdy9TNjBCZ0dlVGZJY0lRamo5RS85ckpJMFU1NUhhdzJIanFiT3NM?=
 =?utf-8?B?OS83OXpzWGJDUmxFaHN6cjhHRzYzR0QyaEF5VjR0YXJGOXZGT2FTaEhBa254?=
 =?utf-8?B?VEp5UzdQUmozdHJndU9rN04rMEVVaGtmR2hiZFN0TWpmZkhzUXQwdHp3blFC?=
 =?utf-8?B?M0VCNUI3ZDFBOUV4a3JPRENvTURIeUlMdkpoNWV4WEdQZ0ZZeC92clUvK1JW?=
 =?utf-8?B?WGR6R2pSdnA1UTVNaXh1eGFiUEF2U0I2QTdLNmc0czNhTW1uZkNMUXRVSkRl?=
 =?utf-8?B?amhaRWxCSkJpTWk5UDQxNmdld0RjTXovWUlKLy9wNlBhZU9wclJxZVQ2ODg1?=
 =?utf-8?B?Y0N1YnRQbkswb3F3NzRjWitBWW4zM2ZtS05rTm5sMTdGdDRpK3pWZDFWRzI2?=
 =?utf-8?B?UGNQcUl0aVNiZUlaNFRNckdZakF4ODcwM2VnT1hlSmVFM2ovai9kd3RtZUhj?=
 =?utf-8?B?REFzdE5kVWJUNER5ZXdPYVZuQUNnU09LVjhVQjUvdldPL24vNGJiNGlFSVpk?=
 =?utf-8?B?SGpmYVpicnB5Mkp5VHlnbG1TaVFCaytDMWU3eFJraXRIajV5bU1EQTJuRmFF?=
 =?utf-8?B?Zk9GYzVZNlFWVHVTWUR0WFdFNzVad0g4UW5zanF5UWVpQlVMdVIyb29IZFRx?=
 =?utf-8?Q?qSiI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWhQZnF4UGc1bTdESGgvdHBmdTJaRW10YU9pMHZBbHNseWpMcXRxWnI4RmZD?=
 =?utf-8?B?QjljbTRMSktNcHpraUJJL2VGdlU0NEpXMGY0ZWlDNXVNWGYvMmpxbGJ0OThN?=
 =?utf-8?B?WHFlQkt3RmI5NDZJbDNodWFnVVpNS0xkaFlKcWlXZjZ0amV5dkcxZzc2YnhZ?=
 =?utf-8?B?eWwvaE5iS1NSSW40SmdHVHFkMkc1NWhReWI4a0NNbkJ4bDdjd0NpU1dTOWZU?=
 =?utf-8?B?aXJRcTdTSUQ3REZPNjMvV2ZtS3NjZjZxeDdBbmNlNlllMy9RN3M3QitZK2Uw?=
 =?utf-8?B?Z2JoNFFCS2QrMnpkOCtGcC9QeWJLeU9qdWxUdjQ5UlRjb3NDZ0E5WXRPTkpa?=
 =?utf-8?B?MG1teXg0MjhORkt3ZHJIejE2TW9KNS9SMENKa090aHphRElSRnBRL0JrTlQv?=
 =?utf-8?B?S2E2NC9lOE5DM3NkUnpQT2VGaDYrZDFSS3dpdWM5Ty9BNlRpNWZuYkgvYUVE?=
 =?utf-8?B?cllab2JzaFA0VzFwYXBrUVBOVFVwRU9kZnFZSmlSb2dwYnNTazBhYnEzdHQ2?=
 =?utf-8?B?MkVIbVpmNzJmMjg4Tk1kZGNucnRXTit3OWxYOXQ2UUx5MTh0RkpQTC90blR6?=
 =?utf-8?B?TmdTc3VsVE1nOVdtS2hsMjdTU2pVdG55MlJyVlRkVzl5YjVoVENzRzhXZ1Iv?=
 =?utf-8?B?em4rYThSWTNxMjAzYmVRWHRDODNmUDM4empxZ1hmQTByRzBQcnVBU0U5K0tY?=
 =?utf-8?B?aHJXYThlZllXVHdrYzZkZDZ5QTJKTkpiN2hOemMwSUhjakpOeWpMWE9mN3VK?=
 =?utf-8?B?YXRadWN2VWtIQytaK3VSdXY5cWNiUU11NjBrbGduVW56OWJKS1VocWV3Y0p1?=
 =?utf-8?B?RElhWkxSLzBNelhrNXArTGtOZjVTU3RsdWtwWWpqWkpqRU1GVnFHUnp5Z25H?=
 =?utf-8?B?eGhrMUpvT1YzWXk0alNPZW5adnc5Q05Zdit0WkhHQ1pQcTRqQjd2WTdjVkFq?=
 =?utf-8?B?Z2cwK3FPdkZjb1pZYnFjRVdpK1pkeU5kY09TTmd2ZmhrbEcrMWlBL1paL3pQ?=
 =?utf-8?B?M1pGKyt6VGlHaTFEUGJDY216ekxneDhuRHpBWXk1UEU2RnhtS2pIa3FFR0d2?=
 =?utf-8?B?UzZOeWtheis5QWM5V3lBQS8wUEU5TnJRUm9yUEZpMkp1dTl4SlhRMXZJSStV?=
 =?utf-8?B?ZjhHZXUxSUdCYWNNTHluWk1SS2lYTDJkQUV2cnNKRm5XME01eXcrRzRIanlx?=
 =?utf-8?B?bHNwNEVnTUNTWFZOZlY4ZVQ2ejYvdldKaFUza0VTV0oyRUlrZ3dwbVFIc1N0?=
 =?utf-8?B?dzZOclBSZmZNL1EraVA1RXdCZ2JNOVV1V3ZTU0FOUXJYSld3Tm9wNytZMEJ5?=
 =?utf-8?B?bFdVWUhNc1pVcCtSZTNZRVpxbk5ob0xGTE8xUVUvMGRSOXc4OUdDeDlQUTFQ?=
 =?utf-8?B?Tkt5SExMdlUvR0xVZUZkZ2lZa0o4OWRJb1J4bU9KdFo5U2kySHRpY2pTbm8z?=
 =?utf-8?B?cm1jbXFlWENEVU51ZGQrR3pBdnFGWUtvN0t4ZXRTRDZzaUtFRlJYR3pTSnM5?=
 =?utf-8?B?Sk1hdldnRDdyclBaOG1keVJHamxhbkl1TDZqcGYvSFV1UVcvK2xxdEd0UkZV?=
 =?utf-8?B?UjN5dk1neElTYzVoZm1NWjZDMTlUeWk0MnN6WHE0cjEzc2pZT2oxc21DQm1T?=
 =?utf-8?B?L3hKRnJMaHF4ZVVlQU5sOEkzNWJkL0Jqb2dhdXJZMy96aXhKNVU4T0dUWXh4?=
 =?utf-8?B?RndJZzNxcEV4ejY0LzhNRVhsbERKNnVPWGdITmVmeTlwWHI1YjFoa2Y3QkFw?=
 =?utf-8?B?M25KcTVQVzA1WWZ5ZlVFeTlJcmFQbU1YcDZmSjFIeUIzRVo0bGVPWGxFL2pv?=
 =?utf-8?B?YWlYU3J2N0hhZzRhTkQ1NEZuQVBuNlpkbE9EbURyVmNXazZXc3U5UkR5UERC?=
 =?utf-8?B?cnUwRkVKZ0h2TGg5UUs2ckVMOVlMRVdpZFZ0eTNqZUk5WDdvMk1DbTg3akZl?=
 =?utf-8?B?ekxxVGFnSkdZWmNqUFEwaWdKNVdmYVh0VDRoTENDUnNFbTl1dWdaVVFuakVX?=
 =?utf-8?B?YXJ3RnpQYjJSRjhyVGNWVkJJQjBIM04rNlAyU09TV2t6MCtHR3FxOHl2N0Vz?=
 =?utf-8?B?WE93ay9WaEwzeThyQUxiUmJKRy9mc3M2ZDcrUC9HbEJtVGdVNE9uUkpZRUpJ?=
 =?utf-8?B?U1hON3NuWDYwZWIwa1RtRFJ6eHRpdHpYcWx4aUs5WElMdkhDRU1FRUFBWnVw?=
 =?utf-8?B?c1VUTklLdkNwZHgwMGdHSVNaNFZneUI4bHFURTRIRFkvcU5objlrOHFaY3lG?=
 =?utf-8?B?Ui82ZlJUMEcwaWY2L2E4Z2ErR3hxeGJuaTB6ajNQcStabjFSUWxOMWxWbC9s?=
 =?utf-8?B?TDJ2VEczVUdFTmRzWTJKazg3RDR4anQrd1RrNXY5YXRlWkc1a1hlR0N0UjBI?=
 =?utf-8?Q?Mj1RYDwJ6Ob/2xAQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d111d35-2a13-4e8c-666a-08de5a010dce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 21:56:10.7291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nr14BpqCGX1SPdIiWtz+iXXqCvEltNoehuRKvWdtrb+ObUcBW6Zbg/4yirmRVYFiU/QmC+tG294hpjiyM0pTyhpRqx+1KQ6c1hFmtQ1T0OI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6014
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> Obviously really applies to earlier patch but maybe it's worth 
> 
> 	struct cxl_port *port = &dport->port;
> 
> 	if (is_cxl_root(port))
> 		return port->uport_dev;
> 	return port->dev;
> 
> I'm not sure it really adds that much but is the sort of thing
> someone will post a patch 'tidying up' later.

Sure, folded.
