Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863FC625;
	Fri, 11 Jul 2025 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752204137; cv=fail; b=obcgwO6YIMwWduM3/mZudxymTYd+KXH2QxhkezoWx7ZMacxWTblKRYxRZEP3vHpcBCpAeEcGQ4FGUI06KYC1Ej5Gxk/mzKJukzHVrFhl9Z+ASpFMo5uwb3zQRuWXm2vwPwqv2Glx5MjgQ1SXESNsI/ytZPTJkIeuhJR+wWhWvdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752204137; c=relaxed/simple;
	bh=YkQocf0a8R0bAH8EL8vyY1ABNN3XLhmYJp5M4nkgJrc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=D+bBqAq0Rvc8SS7g3OVAgeRjS1g0psUFjPB17ybPCuhXuPd+UeU9CWD5LiP4OiTYIRK38XbRSt86+2OVpQbrHTu/ektiAh7AqD6rXrzWXVx4aTqRZFjo3UNAfNmgG/1Q/HA3pQszv9rqhNHublCfPQ8VEMLCLoDXiVOaLPk4UeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiwbQYkd; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiwbQYkd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752204135; x=1783740135;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=YkQocf0a8R0bAH8EL8vyY1ABNN3XLhmYJp5M4nkgJrc=;
  b=hiwbQYkdUo+Q710eTyWA+C92/fxPsmOALx0zTk7VMT7LE7A7seLM/tCk
   hYlc+Xcrh//+4sJnTWtScuOAOK2L/hf7r515yzFpxTd7yncFGv73Nnt7P
   il/O7WS8dcLA64LQKtRfhf1ZpNo/L8r3L9ME0mNz48NmdFIiIB3RTuJJx
   E82Ah0nFCTjtBZYJbHEnp44Dug6kYcvF7bv/m8bnQEil01Ko6NzKIw+pJ
   SJSxtBX89Qe34CpQ3azC4t4EHmkXvhPAzdNEzrTIMaY+tKiBLqOk57aa6
   4hiW8gOPXRLfHJDOBpn/KRJxi3ENt6wp7Mg3lHHpz2+9dSdoTG0LdyEro
   g==;
X-CSE-ConnectionGUID: irYlNFCrTRyfJBUvwpVXYQ==
X-CSE-MsgGUID: 28Z3DXpoT0SM4E/npfeKhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="72078765"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="72078765"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 20:22:15 -0700
X-CSE-ConnectionGUID: nFyQic5FQdme3CuWQC+eWw==
X-CSE-MsgGUID: sTjJit5+ROaR2HxKvNwsVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="156987055"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 20:22:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 20:22:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 20:22:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.65)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 20:22:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pj6QF14nrLwLeP1sj+z4fHyrb+nF7HahyoiC6CV+M+YrVKizJ4I8ix4EMuUbm5aO6hwsV3BhYksu42RzXBC16a0KBjd9gMbB0dIpckU94aJh40MHNQwB+I2BLNHtUPw4wQ9ADDb1x8MqZR3mOd70KNVoJm+hKX2ia35XUuOVT1Ms5y4UVT1OxqFenaTjB0BCKdo4KrqzyhpGRNs8juYCQADVPEFhlZR8SktFB4rkJz6FOT7ia/0K4S8S03oLhniBoQP+ipLxKUu5hAmRnrOHrPRZvew9gL7m3+vB0HU3IUOeXQOqB9V5xD5NWTafRIo4BF5ozexaqXasYRkm6ajaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsVqL5wNavBw2bBfVFSyDnqfblhjaENL6CM6IOB+NSg=;
 b=lFD5I8JN8zM0vYUQxL9l2y8PLg+zNdmTJBUO3JQVSIvWnHPaDiVUZ9xpgegD576azGJJOBlKKAZh4VbfqXdrhyfn/FrJp2qghooYJWA7BY4421sJgWRMPXwUcFes0TXf9tDsQ5w3pDefWe+1umipNIKq6HMyKKYT193X9OLDjGTVCFvga8pxxkNNbZRoca+Hw7IkCDNKmDH/bjvtWuXIavVpB+LPqqVtUL4U4MongJ8FLHk5mQIwBj8K5q37JMu3yid3ZaSTctxZrnSIXrQOvvNjqh5Gl9Nmd04MHRP+5Z8QDEiS9WGL98akuzyAJbfnM5CC0FuucFZHaCxOEmk8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7260.namprd11.prod.outlook.com (2603:10b6:208:43b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 11 Jul
 2025 03:21:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 03:21:33 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 10 Jul 2025 20:21:30 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Lechner
	<dlechner@baylibre.com>, Peter Zijlstra <peterz@infradead.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	"Alison Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Shiju Jose
	<shiju.jose@huawei.com>
Message-ID: <6870833aa1344_588c100dd@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250623113208.0000768c@huawei.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-9-dan.j.williams@intel.com>
 <20250623113208.0000768c@huawei.com>
Subject: Re: [PATCH v2 8/8] cxl: Convert to ACQUIRE() for conditional rwsem
 locking
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0114.namprd05.prod.outlook.com
 (2603:10b6:a03:334::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0eaf15-8b9c-4608-8a00-08ddc02a08c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWc0anZ0MXB2cEpyQjlrUERkV2daZzdmTkllZVcySHhwK1cvRSs2RWNVODN5?=
 =?utf-8?B?dmxwaDJ0VzlFME5MV0lXMWxtd0N5S25CNzhoM0lONHd5ZjJOb1N2OUkvSDdU?=
 =?utf-8?B?S09hT0Fwa3gwQXpNclFnWk1WVC84b1lCcXlBWENtenhwd3VPaFVUVkJSZncx?=
 =?utf-8?B?RzBoWVNDbWlLNkhuTEgyTUpMUG5oY0ZvMTVpVDAwYmRGUi8wNmVRUFU0c2xs?=
 =?utf-8?B?U2FHMnkzV09OajMzUldyWkZYK0w0Vlk2VzdhNko3RDBURmdXOUp6NzdFeDdD?=
 =?utf-8?B?Q3Y4VVZkdU03OWwxYnVXTEJxT2NZTS92dnk3QzZFQ01YY0FXUVJUTlMxRHFx?=
 =?utf-8?B?V3k0WVNobk1qdWRyUnpRM2hid0x4VllHREJmS3gyZEFPd3hjV0hubGNoR3lm?=
 =?utf-8?B?UVBkQ2JXNlJLdjNoTFIzU09sSmdGNkMvdWhxdnpUZ2xkWExteG1DWitYU2Fq?=
 =?utf-8?B?R1ZYY3JES3Jpd3Y5L3Q1bHhzWHhGblk0dnM2U2crYzJmUEh6dldZVUpJK0VT?=
 =?utf-8?B?dFF0VVcvQUNJQWVZbkxiMWV4R2xTakhkb2pVRUE5ZjRmVUVXZWhXSjR4QS9Y?=
 =?utf-8?B?TGUyLzRkQzN4VDd6YnpHRjVzU2FYR3IvUkk2cVA3ZCsrY3R0SDArekR6Vy9m?=
 =?utf-8?B?S2twWUkvTVZFYStaTWUzNFNubVJmQUlaWU5xbDNMVlNRSGpDQlljNFlsaWlK?=
 =?utf-8?B?aHBoTnI4ZXF1NzAvWXFWOHJFd2ZvTm91WXd2eU5mNElnVDM4Y2xKMjlONHAw?=
 =?utf-8?B?VVhDb1RvY0Y3NGRnZHhOLzAyaHd2MWt5UW1CSVV4d2hGV0FsS1RpMWVVT3ZE?=
 =?utf-8?B?T0JNWjRmblNaOFY0OVJQSmt4UlM0cS9jTVhKUnVLTnM2ZDlIM2k5bU5JV2Jj?=
 =?utf-8?B?K1F5QjdWRjZmbnRWWkMvTmNjcXRHOG1JV2VIK3QveEdmTnRSWi9UMU5ISUV3?=
 =?utf-8?B?cHBUSkVsYWVKSGxpU3V4bnNNMWh2U2lENWlwTEZ3YVUxNituaVNDdG94dXNJ?=
 =?utf-8?B?RkRSbkxKQWp0WHVtdW9jQlZxNHhSc05aSHlVMXpFM2h4SERpS3BuUDB4aHox?=
 =?utf-8?B?UzdhYWtvQW1VUHpZcEQ2ZVY3ZmxEZzNLaTlDNFd6Y2V6RHkzYWlzaG5qRUxh?=
 =?utf-8?B?VnpDR3ZGT1BLK2tFbXRNdUtEdUpQdE5JTHVrSG9SSTFwSG5qVWN6SXpJZHpy?=
 =?utf-8?B?V1Y3aTlNdGNsN05JMWJzZkhNVlZ4N0RURzE1MVVqTzhiM1R0bE1xYU1SbDN3?=
 =?utf-8?B?NUZvNTFEYmlOL0dwTFBFOTZIRXo1dDM3N3ZFS0hDMjNzZGdBend1QVU3SEIy?=
 =?utf-8?B?d2draU5QbHpPcnpiNG94dTk3dm40NXJra1FuWk4xNlM2SGtOZzlkL2xUa2o0?=
 =?utf-8?B?Q0hIQjBXMHI3WEpPUkRoWkpvUTR1Vi9aRjI3QllLbndTYnQvTEFROCt1UzZm?=
 =?utf-8?B?K3ZES3k1STBTYVN3bDZycHBFczRoM3pXT0JlakdQMTRORFFQNnR5VmpIUS85?=
 =?utf-8?B?UFFkaWF6RXBieWJPek0rK1ZQNmpHVitqcEZpUHp5YmczTFJ3dXZBT1VGZmFX?=
 =?utf-8?B?Q2NONmFGMXdTY0lUbzNZUTgzcjg3NkhNUHQ1ZVFGWDk1RVB1OXV2ZjU3M3pD?=
 =?utf-8?B?d01SUTBvcU1jRFBaenVhbnY4a3NDSnZDeGNuVndTa2lpcGw4MGFlTHhOOTJN?=
 =?utf-8?B?QjJsK2NNVmRsNldmWUZBZzFackYyV2pDbzZOMnRUZjdUVlZhRGZ2R1JYT0Q3?=
 =?utf-8?B?Y01iODJ6bkpSV2lqUytSZXhNeXlOeUxJVlFLT2t4OUVHVjJCK1NncGJwZVhH?=
 =?utf-8?B?dHpLVGxZRkZadjF0Uk04UTcvY0cvamJCYnZxc05VWnordHZjUytrU2NCSUxq?=
 =?utf-8?B?UkNZYjM0dSt0d1ROZXhxU2VOVDVPZmZ0LytDbnQ1RVJqVlVDamFlM21iTTFZ?=
 =?utf-8?Q?Wcd2KPclesE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2xKRDM5eTFXWmt1WkVyaVZLdCtqNHJDNWxRcHg1N05FWVpLbjQ3cVhoTnk3?=
 =?utf-8?B?bjZ3djNSbG5LRWJZamRyL0tMaHkvVGFyUFlDVFQxZkhhbkRjNnJhVWEvNFpT?=
 =?utf-8?B?Z0JQRElqQkdQd2NhRVI1YmROdEw1R0dKNXNINmhDTzV6RmZqa1MybncvbTU4?=
 =?utf-8?B?RkM3YXZkSklQaWdoWmQvQ2dMN2ZzWHk2RFUwQmFRQ0VDQUdQMFJGZkFNdk9E?=
 =?utf-8?B?MnFkb3E5Nm9zQkxuUFo5SW1KQXhxcFZ4bXYvdDJCdHlwcU9NR0djb1Fsd2dy?=
 =?utf-8?B?MEp6RlRUTWhNUjFPRFNrMGxwQ0NuUGVjSU9sMjRSeFVUN2wveFpDcWdIRUFq?=
 =?utf-8?B?OFdBUE1CMmkrWHRDdC82bkp4YXZZUllZWndVakpUYmZWcmgybHFRM3pLeTVN?=
 =?utf-8?B?c1N1cWZIbFc4cTRia3pFU2pOQjN3ak1nZzhCaWJwMmlsL3NKRml0aXg4akEw?=
 =?utf-8?B?NTVJbjJsby9abzltUU9oZXhCeFFESGtTQ2p6eWdEMUVEM29vMWlBVDJWaGlB?=
 =?utf-8?B?dmNqc20rZlZmYkdrOHJFNisvRVFPK21sZDVJMkM0K2NyOUQrMkZkN2k0Tkgw?=
 =?utf-8?B?UEZoc2xydjZTZjVMWC8zQitKZ3JQRFdOcjF6OE03TzlpSHpLMUgzcFhaNGtS?=
 =?utf-8?B?VlRLMlNwaXgrbHdta0pKVHlndnNHUVlFZW4xNFlZM3FkR2pFMGU3Y0dPekVv?=
 =?utf-8?B?dTJ5ZlZrRFdXUWpyVmhNaUQ5UHU0TUFhck5iNjNCcktQZ1RuV0NJQm1OT0d0?=
 =?utf-8?B?UTdDVWtQeXZIblVLVkxYbG95eU1scW84MnVHVDF5ZldwY0I1R3pWT2txOTJH?=
 =?utf-8?B?cjY4TU82SitwSWYwSzFGVFVOWHg4M2I3YTZLbno3OWlueXZVN0ZSbXJ1SWkr?=
 =?utf-8?B?bTErYW5HQ3p5N3Bkam5BOEJyNzY1SkZUOSt6YmRFdzh1VUUvMThvellsQ0J6?=
 =?utf-8?B?ZHhQTEhVWXZqbTQ2L29LVVQxTnZuSUgrUW1kMnp3NlFGdXduc0VlK245QWRu?=
 =?utf-8?B?YjE2MmtpcFRLSGV1c1l5aUFBMWo0ZzEyTkF6YUFpdU50bE8raGV3YmRBd2hn?=
 =?utf-8?B?REQ3cTdvNFRDZXY2b283OHQ1aTkvT0ZRWTZKMk9MNzVMZjlQMHllRW1vT1dI?=
 =?utf-8?B?Zm9pSHhRODBWWnV4UnhyNXQ4dk9zR3IxRVhCQXpudUVubFFPWTgyWERPVTli?=
 =?utf-8?B?OFNkZ3ovZ21EeFB3bUtPWkNia0I3S2I3aTJUVGs1Tk8vYTZ6em85TzhnVXU1?=
 =?utf-8?B?N3Z4cVNnRkF6emtmeWNxZ2xUeXJ6dmtHV3AyTy9nYkttaW1JOU9KNDhSc3B3?=
 =?utf-8?B?bnhtNXBxRlVtUHFRMWFlSHNrK2lDaUhDQXpXKy9aWDd5SGNPWXRkRjFwZnVE?=
 =?utf-8?B?cDNMdHlVY1BNTnFzSGxnNlpsNDdEdGdWVU9YU2lkSGpUNGNxVEVCQWNIMUxQ?=
 =?utf-8?B?OXhxY2dRZ3BVRDlCRW9hV20zT2FocmR2OXpyNGtpWlN6RGNoVlo1UnFkZGdF?=
 =?utf-8?B?K3dSZUFFVjUveFY4bXRvUGpWMkM5TDBqZlRSUnd5MGM0MVJmZE1CaVg5NVF3?=
 =?utf-8?B?dkF4ajJLeDUwZUlGbjVxQzA3WkxGSE54Z3RGTHlBRnZpZGlaUnVpaXplWmpl?=
 =?utf-8?B?ZTlaYWh0TnlYODNQcjBLbDNTdm9YVHlBZTZvKzZXeE5HNjhjRFFldGNvb0g0?=
 =?utf-8?B?YkJ3RURqeEJFYXpHaEVEK0VQZGkwMGNtSVRBYmtwRXdIVG9KeUNubFJVZEdw?=
 =?utf-8?B?OHZkcFJnYTJEVERpeitNUldBV3kyRkF5RXZSeURvM3VqamR3QW5iZkRYYlNN?=
 =?utf-8?B?RExYamdwa0tRNmFrMWdBTnNwdnZTWEp4VWNCaG14SDZENHNIYURROVoraGNS?=
 =?utf-8?B?elNINURYZ2QwRHIzWEQraWlhcDdWcjgvMExDK3h6M3pqQVVRblN2WEFBVjV0?=
 =?utf-8?B?NkhwS0FpV0ozcjNIR09UaVJ5TjUxNERoWXNIbTZEOFBibG4zK2hISXVRRkZq?=
 =?utf-8?B?d0xOS0hNTFJ2a2kxeVFjSzMyU2VCRVNlYWUwaXh0b2FibEoyYnduTTBhRkU4?=
 =?utf-8?B?aDZmOHlmcEtqd3c1WVp5VG1SZHRGblBaMzRhZVV4UmlDaDVPaHFWUEJGU1pk?=
 =?utf-8?B?V3dlTnB0UkV4TjNRWk9HTWw5djdLcGRiU0pKSXhlMXM2YWZBUldjYjlxTDN6?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0eaf15-8b9c-4608-8a00-08ddc02a08c1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 03:21:33.1347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCpFskoyHoNETyUcQ5h7uQupHvQYhKsWYGcJMBDDCiVq2DwFlJ3qb9EYIB4peELh8on0VwevKz7tYDIu9mrJTsuOd/L58Q2y/32vAyB/jjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7260
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 18 Jun 2025 22:04:16 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Use ACQUIRE() to cleanup conditional locking paths in the CXL driver
> > The ACQUIRE() macro and its associated ACQUIRE_ERR() helpers, like
> > scoped_cond_guard(), arrange for scoped-based conditional locking. Unlike
> > scoped_cond_guard(), these macros arrange for an ERR_PTR() to be retrieved
> > representing the state of the conditional lock.
> > 
> > The goal of this conversion is to complete the removal of all explicit
> > unlock calls in the subsystem. I.e. the methods to acquire a lock are
> > solely via guard(), scoped_guard() (for limited cases), or ACQUIRE(). All
> > unlock is implicit / scope-based. In order to make sure all lock sites are
> > converted, the existing rwsem's are consolidated and renamed in 'struct
> > cxl_rwsem'. While that makes the patch noisier it gives a clean cut-off
> > between old-world (explicit unlock allowed), and new world (explicit unlock
> > deleted).
> > 
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Shiju Jose <shiju.jose@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> A few comments inline.
> 
> 
> 
> 
> > index 010964aa5489..a2ba19151d4f 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> 
> 
> >  static DEVICE_ATTR_RW(interleave_ways);
> > @@ -561,15 +537,11 @@ static ssize_t interleave_granularity_show(struct device *dev,
> >  {
> >  	struct cxl_region *cxlr = to_cxl_region(dev);
> >  	struct cxl_region_params *p = &cxlr->params;
> > -	ssize_t rc;
> > -
> > -	rc = down_read_interruptible(&cxl_region_rwsem);
> > -	if (rc)
> > -		return rc;
> > -	rc = sysfs_emit(buf, "%d\n", p->interleave_granularity);
> > -	up_read(&cxl_region_rwsem);
> >  
> > -	return rc;
> > +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> > +	if (ACQUIRE_ERR(rwsem_read_intr, &rwsem))
> > +		return ACQUIRE_ERR(rwsem_read_intr, &rwsem);
> 
> Local variable?

Yeah, I think this was leftover from playing with ways to make this
more compact, will switch it to:

	if ((rc = ACQUIRE_ERR(@class, @lock))
		return rc;

> 
> > +	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
> >  }
> 
> > @@ -2212,19 +2167,19 @@ static int attach_target(struct cxl_region *cxlr,
> >  			 struct cxl_endpoint_decoder *cxled, int pos,
> >  			 unsigned int state)
> >  {
> > -	int rc = 0;
> > -
> > -	if (state == TASK_INTERRUPTIBLE)
> > -		rc = down_write_killable(&cxl_region_rwsem);
> > -	else
> > -		down_write(&cxl_region_rwsem);
> > -	if (rc)
> > -		return rc;
> > +	int rc;
> >  
> > -	down_read(&cxl_dpa_rwsem);
> > -	rc = cxl_region_attach(cxlr, cxled, pos);
> > -	up_read(&cxl_dpa_rwsem);
> > -	up_write(&cxl_region_rwsem);
> > +	if (state == TASK_INTERRUPTIBLE) {
> > +		ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> > +		if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)) == 0) {
> 
> I'd lift the warning print to a wrapper function so that you can
> return early in error case and avoid this rather messy line.
> e.g.
> 
> static int do_attach_target(struct cxl_region *cxlr,
> 			    struct cxl_endpoint_decoder *cxled, int pos,
> 			    unsigned int state)
> 
> 	if (state == TASK_INTERRUPTIBLE) {
> 		ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> 		rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem);
> 		if (rc)
> 			return rc;
> 
> 		guard(rwsem_read)(&cxl_rwsem.dpa);
> 		return cxl_region_attach(cxlr, cxled, pos);
> 	}
> 	
> 	guard(rwsem_write)(&cxl_rwsem.region);
> 	guard(rwsem_read)(&cxl_rwsem.dpa);
> 	return cxl_region_attach(cxlr, cxled, pos);		
> }
> 
> static int attach_target(struct cxl_region *cxlr,
> 			 struct cxl_endpoint_decoder *cxled, int pos,
> 			 unsigned int state)
> {
> 	int rc = do_attach_target(cxlr, cxled, pos, state);
> 
> 	if (rc)
> 		dev_warn();
> 	
> 	return rc;
> }

Yes, I like that better.

> 
> > +			guard(rwsem_read)(&cxl_rwsem.dpa);
> > +			rc = cxl_region_attach(cxlr, cxled, pos);
> > +		}
> > +	} else {
> > +		guard(rwsem_write)(&cxl_rwsem.region);
> > +		guard(rwsem_read)(&cxl_rwsem.dpa);
> > +		rc = cxl_region_attach(cxlr, cxled, pos);
> > +	}
> >  
> >  	if (rc)
> >  		dev_warn(cxled->cxld.dev.parent,
> 
> 
> > @@ -3569,30 +3520,23 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
> >  	struct cxl_region_params *p = &cxlr->params;
> >  	int rc;
> >  
> > -	rc = down_read_interruptible(&cxl_region_rwsem);
> > -	if (rc) {
> > +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> 
> Similar to earlier - I'd do this next bit in two lines for slightly
> better readability.  Same for the other cases. I don't care that strongly
> though.

I want to keep the compactness, if only in the CXL subsystem.
