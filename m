Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D15258;
	Sat, 21 Jun 2025 04:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750481488; cv=fail; b=m7YHNvrbqJeqPunkAxkxWLJ1zE77WQ9S2gLzoPsgtIkxkOdu7mPdAfvWA3KRyecdyvEJwmH3bTU+U0G7x2TSwfUHYPS/Y2WwuHn5ez/bWZdiB5VQZudiSLUfOfm318MeTRlSS7Lxxt21ItUhCpSnvCGTnBy+TA0gONWVu72qgg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750481488; c=relaxed/simple;
	bh=KIGnKtSbvB3suC80R5diJUt4R6p/ChwERuGG2aM8SDY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ZVHI8bVMnzj1pyXqGV7yIdvHRJVpH4mC2Ui6z/2dBnF0WZIQA2sBErE3s+HbVmO3fqV03qWEj2gxtkZylpnCUaNA2Jp8tBMWcCaHjVCyEGUGfmBX9AUYiPIfGk0oIv+Q0MYt9vZO44hc3q9I7ALwWX02G1rdu99JOqZS2rN0VZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EfkwE/ta; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EfkwE/ta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750481486; x=1782017486;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=KIGnKtSbvB3suC80R5diJUt4R6p/ChwERuGG2aM8SDY=;
  b=EfkwE/taM0KUwLdZeUv9ke5HaE/7P2Zp7ucDZgUdI/T/bxFPbc1AEOyI
   DU2Zm4C+oINgg4LofH2EI5E1PBAEERLfXmnjPYTF2q99l2OyhI/uf5Til
   ajtKEIW/SlkgibNolPwc6KTi40fGW6H6KBCOZYfmZMwKy52k45Qk8tvgZ
   fOQaj7Lif9TewpFtRS/1MMNqr0c90JwNj6Nnv/7nEDbH+Vx5V7Mb+3pai
   m4YOuWECznkEXNEIoUZZqZOK/iqb3BTaiJX6Ey7GKED/WA1Ksek7KUhUu
   rra6tI7JFcDkdANw5bNcf7xhMsrEbijhrLfexq19yQgwneSNykpJUQLFw
   A==;
X-CSE-ConnectionGUID: PNzRO5ukThmtuNrRmvA91g==
X-CSE-MsgGUID: tblQSAcpS2e1iDEIsg4O5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="64101735"
X-IronPort-AV: E=Sophos;i="6.16,253,1744095600"; 
   d="scan'208";a="64101735"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 21:51:25 -0700
X-CSE-ConnectionGUID: gAMT3wQLSYWIg+Y/eydkkA==
X-CSE-MsgGUID: pOMZJ/5bSVWEs6tFYGJtMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,253,1744095600"; 
   d="scan'208";a="182114611"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 21:51:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 21:51:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 21:51:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 21:51:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzQdV//qfZjqWD9rgy8FACiBHTJiuDD3qOXwJ0Du9iO3mVcX79o3pdPoW2sX3jLbbJOi2i0siWMqgkRvprhP9TxPm6azmEt1KgIfkRm4Fn3dtKIayeiRGRzcjjKBuV/IrX4BZ44jCY5Z+SraXixclkyaRFlme/kjxmRWuqVrT1jcv2shl+DpFFUINKfZJ63Lg557IHACjlybqMZn/7ggk3BcdWIeDrXgFYlrfL+ziwuBYQn3Youg1MaS4w9GlgYM+B0JsOKvT3ikc1MYAVyzhIm0wMm5+ZVBs4FNAPLn1mcISjIONtUmbyg5JKUkZ3MTIuUi0SZCygebgR+gJ3oOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk+VqG+H2LOWGGanl69XqvpAzW68g7Fs58K578q7ZQs=;
 b=tw8eKUZoKVu1vBB+w02nXg89yNLLJa+ClNrvZqmzYJTio3w19fIET3HotTa16hViM0zpgbI+7hO12iuL1TmUnqxz5Oen+A7liyHp2P0A+BUNgjnGNJdKCeVREPgaVi181lhidf8S1OtjJxWsJ37UxF7U8I8+lBPA/hhvzJPlvxwJYo5s0EpsHj3X06jw0tiJqXU4EYE3eIjNpSf5mLrZpMLxvJ/ojwaFdye9m8LHacpH/C8lPflfaXzX8vrv8nRpZFrOCidUF9XLgky0L9ra/RavzYv/a/YxfM/IbKt3cMp1dgsyPCPan6O9ZhuOFPF9Nw8bR5vbbSK5hDIO+o6jWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7440.namprd11.prod.outlook.com (2603:10b6:806:340::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.35; Sat, 21 Jun
 2025 04:51:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.027; Sat, 21 Jun 2025
 04:51:06 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 20 Jun 2025 21:51:04 -0700
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Message-ID: <68563a383c145_606210037@dwillia2-mobl4.notmuch>
In-Reply-To: <aFXTZVnyPoxGRIcj@aschofie-mobl2.lan>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-6-dan.j.williams@intel.com>
 <aFXTZVnyPoxGRIcj@aschofie-mobl2.lan>
Subject: Re: [PATCH v2 5/8] cxl/region: Split commit_store() into __commit()
 and queue_reset() helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe2fa3e-6ad5-4356-09a5-08ddb07f3b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlpmU041ZkY2TGhIYTNKcXFPa29rUU4ra0d2QURtUm5Qd0doYm1RY3E1TEdO?=
 =?utf-8?B?S25aMW9xbFJad2VvVE1acnJzTlkzVEl3RkJpSmd3QlFPUGorbXNzNHRHcDRJ?=
 =?utf-8?B?V0g5M0Z2Mk9uczJ2SitzZzJremk3a1pGY2I4Y3RoZnhHNjFpWUZ5ckxna1Fw?=
 =?utf-8?B?L1Y5a1BUcG5MbWFQam1zam5XNTBKSW5FdVRTS05EdDJmeDZFSGxQTUlGS0dz?=
 =?utf-8?B?QmFIWXRiVDF2b2RBMUVBcndPbGRFMEVKcmF4RGRNSC8wM2NSNENHdDFMeGdP?=
 =?utf-8?B?a2VBY1A3SjdhTkZLK2dXYWZzNEpjdThGQVdLdE1HRGh4VTBLdnRkWDZ6N3dM?=
 =?utf-8?B?U0M0SlUrQXVwT1J0aWxmaDByeng4alBkWEZDZVQ3SXE3RFA5Vy9rUVd3RzlS?=
 =?utf-8?B?UFZiY3RsSnBvdFZyQjFYY1hVbm4rYXhad0tCV1paMHZTMWw2WUd1SE1mM0tS?=
 =?utf-8?B?TDFqaFJpd0JZRmxFRm9HVkVBT1V6Y0h2Z1JsdSs0c25vS0J5ZDg0dkJ4WjVp?=
 =?utf-8?B?NXdFYTk3NW5LUnR3N3cyMnFPaXJRRVprTXUwMlAwNm92S3R4ZHlBbU40Q3pr?=
 =?utf-8?B?WEJKMDNnNGFTdFFlblRpWkxyMkdGQVc1ZGZUdE8vZXdyV0dhVkMwVFRKenJm?=
 =?utf-8?B?QUtJVEMxU2VHUnM3Rmp0WDNNbit2NU95TmhVNm5vNW9OVzErTzBEalJkQmti?=
 =?utf-8?B?ZjBMSEdYZHM0TkRHN3ZoZzZEUDc4QUdsS0x5VkRFakcxVktuRWRyaGNVZ1E4?=
 =?utf-8?B?aWk1NEJ0NnRONjVsa1pJODAvR2djdW9CVzlKQ0FNVjNFYkwyVkZIRXRlY25Z?=
 =?utf-8?B?Sys1ZXFIdmIwakdMWXYzVkRZcE1iY01qM2ZIaG50RWFhaVEvOXhvVnFYazN0?=
 =?utf-8?B?ZmlJZlFtTDIxSGYxa2pHMDNKMEhTQnp4SlRtaUNYTmxIdWF4WVdLRmh2ZHJr?=
 =?utf-8?B?L2JWVHl2MkdicWh2OFYrWGNBczBtRE5rNmVQT3AzUG16a1k1MllCL0greDBI?=
 =?utf-8?B?U1FLNU91UjNCYnVpSXBJTVlEK0VwYVpUeW9jWG5uSDdPWnJzd0dXYjYvTGF3?=
 =?utf-8?B?M0xtQnQxSmJzUS9NbVJwMVlIN0p5WDVIODVpcWNpcGJTekJ2VnIzSXptcDMz?=
 =?utf-8?B?Rjg0dVdtUjllK01CRGlsdUs0ZW1hdDkzNGFDaHNqN2w2UHpKRE1LK0FudjBr?=
 =?utf-8?B?RU9jRzV5SGFYZHNsd1BQN1lkaThsbTg0TTlSTWpBQ1Y2UWlnM2Q2cjZCR1F3?=
 =?utf-8?B?S1BLMndlc2dGemJaNnlrL1RLcE83U1hESjNvN1lHamJHVm5FZlVaRDNFSld4?=
 =?utf-8?B?MzhuQ0tsNi9oQVBpZm91bDBicGFiUWlVTlJ4QWEvaW5pSGVCcTUzT1VLaWNw?=
 =?utf-8?B?eGszYTBlekNnQzRMM3EvODhxYjBMbHN0aGVzTDhNY0JzR0xUS2lraVpmTFdk?=
 =?utf-8?B?bWdpWjQzcmFONEY2NDgwaXoweGQ5emY0L2JkdzhMSndsNUFPQUhjV1JGQVNv?=
 =?utf-8?B?MDFVWUxsS3ZYOGZHVGhUalNHdVJCZ2hFSVpXMHI5ME5uOHNpZUZ3RkpZd1l5?=
 =?utf-8?B?cnlLK2ErVEM3VUdTQ2JvWEMxeGdFZ2VibGVaUjd0ODZaSkcxU2c2REhSR0VD?=
 =?utf-8?B?ZU5EQXV5VU5uTVkvWVhTQzFQQ1lWV05sNEVBVEU4ZVJIajVoMnlXeDU5NFVJ?=
 =?utf-8?B?QlZ1aGhqQnFEMm95QTBIUDNGd3AvSFZSZlBVQ2dJNzNWTnFrL0R6QlZmQmVJ?=
 =?utf-8?B?OGFJRVNCQ09xMlZwcFJCSlg2U3B4ZWZ3WUV3YlZXaUVEQkZuYmwvTjZCWW11?=
 =?utf-8?B?VElsMkRNVFAxWnlVSzNseTJoQVdXWWVoMW02bWpSc0c2WU9rZTV5dWNTRHNu?=
 =?utf-8?B?cVgyVTUzT2UySXozWmd5T1pDTTljS3lRRmpNQmR4dHlUaWtyWnNERlZjdVFG?=
 =?utf-8?Q?Vw1jZ7B2gsU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTBkNERFQ2V5bFQ4VjM3MXZ0blRTVkd0VjBMU09wY09tZzQwZDJ2cDlXdE9y?=
 =?utf-8?B?WGwvZHNKNkdSNGVCYmZubnArSFI2Z2FxTGlxby9hbmV5b0tpNzBPRVNiejgx?=
 =?utf-8?B?TFBTZWtkQVB4dldZeXczRzBtbjdiVUQ2NDdKNnZwL1F1UmRJMFRybVczVDBi?=
 =?utf-8?B?RUQrd0tqcTg1V3N4WFI3SjR5V0pTR1NWMDVGbXdJMUhiSEp4aEplbnk4Tlk4?=
 =?utf-8?B?aXVOUWRDZFl5VTZTc1BUdmx0UlFIRHlVRWlEVnVtUVczTUdxQUUvbnRpaFlJ?=
 =?utf-8?B?eU9YeEUrTEVEa1Bkbjh3WVJGa2VrbVIzZ1l1RjhaOUlKaDl4NGZBTnZ1RVFL?=
 =?utf-8?B?MFRPT3BJSXBpbnp1aEVzTFNiK1czaWpTZGl3aFh1dWdYWjNSWUk5eFZ2eDdT?=
 =?utf-8?B?a0FkYzVQNWNXVktnRjBGSnBDUk8vUDRJcTQyZEtMaU96OEMrcWxta3FDNnBy?=
 =?utf-8?B?RnA4Ry9tOUVLUWdwUktPS0JVMG50U1ptVDdqRllPcnByY0xkRFlQUmZ6a2ZM?=
 =?utf-8?B?cm53NGlCVTdhR0xHd2FjeFpMNmJjaW41NGlJUjFVTDRXaU5kWElWT2lYd1dJ?=
 =?utf-8?B?SmhhcWpSR29XcURWTlNMbG1UZ3BQa3kzUEtiZUhVQXhSS2pyVlBPZTBzKzAy?=
 =?utf-8?B?SDBBczlsQkJXdk1rSWxYRXczU05XL3FHRWFScmUxd2JOZzE3Rm0wbXNlVVRF?=
 =?utf-8?B?Ulg4WmxMb0hkRmdxZndwbHBhdENRc0FiekQwbVBXdGNManpDallNVzk5MmxJ?=
 =?utf-8?B?TFh3WHN6Tk8rQmFONmRVdHhNSkd5OVU0a3ZncVlKR2U5Q012UGE4Mkk5VU0x?=
 =?utf-8?B?YytWRHZNKzF0TFBjWG9BZno1c3VLL3FHeWdXTzlYMTd6d0R6dzBvTEN5ckNq?=
 =?utf-8?B?WDI3M1BzMVVLb3ZIOUkxSnVVcVFCbTJ4ZlhsQlg5Q1RuRXFnU2hxZXZNemda?=
 =?utf-8?B?cXdRZnR0SUtsWWdQOWUvbTJTdTRIVksrRWJnN3lHYzJGeVpmNzE2N2FTY0lp?=
 =?utf-8?B?Q2ZiTm8rM0hBNk5YRmdReFRnT3Uzd0twbHQ5ZFZCOVMzZ0dEbCs1NkJ6aGtr?=
 =?utf-8?B?V0hMellmcGl4ZHJqaEx0bW1GMnJDbk1FYW5yRjF1eDlXeDZWUzI1ZzZ1Mm9r?=
 =?utf-8?B?aEh6d040bExpZ0RmQzBUS0JiRktKR0w1Nkhva0RCT2FDb05vMXBpRnRVUm9E?=
 =?utf-8?B?WUNaK0pUTnYzM2xvVXJGV2F6R0dja0NISWVEb28yQUd0R3hYUGp3dFRLck5v?=
 =?utf-8?B?NXBqZyt2dXZlSnVEalNBMDFRK0hoUnIxMUN2MlVIaWRQRnNiQ0hRaGZ0eU1p?=
 =?utf-8?B?Y3hZSFhhWmg5RjYyK2NwSi9XdnA2OWgrMkl5YUxlTUdHMVlNdGlHSkZUcHlt?=
 =?utf-8?B?NmFyWXp6ak9QYXhORmYyWjkzazRqUzN0NFFhbjR2SkJPK09WWTBNczJHVFZE?=
 =?utf-8?B?aWprTUJPT080SiswUWZ6dlorZ29idXZiSHMvTmVXNmpGSm1TWEYxVDdtaU94?=
 =?utf-8?B?OTdVMzUwQUxQWm9jRDlsUCtwOCswSGxnYkRsRmR1cTdOMTE1dGtoNndXd0cy?=
 =?utf-8?B?d3BIRnlVazFFeStjZjd1eDV6Z3pDTk5nZGROS0NZcURZN1FtRUxlVGRKQ1Ey?=
 =?utf-8?B?TmpPLzZSYWFEWFpuYUZSZ0pjYllqOGJFZjNQMXNqdjJsRDJHMmgySlpUUEFa?=
 =?utf-8?B?VWwwcDZSKy9YZEE1RkZlb3NRenliMnBEbUI3TXBFYnpnaTNvZE50bDlvdjJY?=
 =?utf-8?B?Y1IyZjJDWXp6ZXNPR2FQNmRlb1BMN2wrREtKZ01tZExXOG1ZbCtVVXQxZURR?=
 =?utf-8?B?a2g5K1RsNUMrNEMvdHZZME4vQ3FDS004dEZTanZWN004aUN1b0FhQ3lYbE15?=
 =?utf-8?B?N1YwU1BzNm5JZXlRSzJKTE5vWG85VE0rOXdoWForeWdtSWlKQUxqcVFxR0k1?=
 =?utf-8?B?NEdkeDc3UUF1a1RyaVpnM05wSXgvUU90NGRyMlB4QjYrWTBEVDd1UlI2cEhR?=
 =?utf-8?B?VDZIVjZYWXVsZzdFdjRkRXY0VGNBbjNHK1VlM3RiWSsyQnhEbFdaTWVlQ1V2?=
 =?utf-8?B?QnlIcGNocjJFdEIyZDJBVlVKNHptSDhvWW9vUGppMlY1Z1Y4djhIOWNMR2tt?=
 =?utf-8?B?TU1Kb2hkYmZMZlFoNVBqaFJrMVl3WnlSQzVoaWVKUlRqc2kzNFJjbTd5NldJ?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe2fa3e-6ad5-4356-09a5-08ddb07f3b95
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 04:51:06.7418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KL7Py/jYWSLaC/NDtYViylSMsB4Ee/hs6Q8Z2gnUmmkYRZqk/S8WvntMmrfr3ES8rdJydTnUf1UdcyZFcnSd4plFYJXUdNocXgmrZOKTDp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7440
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Wed, Jun 18, 2025 at 10:04:13PM -0700, Dan Williams wrote:
> > The complexity of dropping the lock is removed in favor of splitting commit
> > operations to a helper, and leaving all the complexities of "decommit" for
> > commit_store() to coordinate the different locking contexts.
> > 
> > The CPU cache-invalidation in the decommit path is solely handled now by
> > cxl_region_decode_reset(). Previously the CPU caches were being needlessly
> > flushed twice in the decommit path where the first flush had no guarantee
> > that the memory would not be immediately re-dirtied.
> > 
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 99 +++++++++++++++++++++++++++------------
> >  1 file changed, 70 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 6e5e1460068d..3a77aec2c447 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -349,30 +349,42 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
> >  	return rc;
> >  }
> >  
> > -static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
> > -			    const char *buf, size_t len)
> > +static int queue_reset(struct cxl_region *cxlr)
> 
> How about defining both new helpers to return ssize_t type for consistency
> with sysfs functions. The local 'int rc' can remain as long as the function
> return type is ssize_t.

The type change to 'int' for the helpers that are not dealing with
input/ouput is deliberate. queue_reset() is never returning a "size", it
is always returning 0 or a negative error code. An int fits in ssize_t.
