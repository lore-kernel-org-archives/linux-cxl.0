Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D67E199FAC;
	Mon, 11 Aug 2025 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952980; cv=fail; b=uXgtDaygJiPGrAPTD7/4kAyaF5QHuks6egYR9JK5HIb1/hXWXh1brXTPbqOk0U5H7ckZ+Qpaybd5kC5Jynggo6Wlv3R1CQNt0bJKhe7F7f8Ly4Vvs3Zg5/2KyRoBnbsWAVVYV8n2A2RBa60xLwsePo1MiCyqWfBOzKK0b6PxfJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952980; c=relaxed/simple;
	bh=VAPRqcIsJ+W07i2z6ZW4s0UnMr9ipCRg2qmeq2kEwZc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=kNhLj/bZzGQPxibHMotLmSQ4VvV/cuAqCig7vxW3dl8Zv/zP3EDRvLUzs1ExH7/H7pYOcOuyybqJIv3BVzyImGRTj0DL4RTuHOtr+7bJ+YnSXRInghcEl4+CvNYYmA9CidOOVdHWm+JTzIM2ndl1ItaWmrBkts2Dk9vvHHM/sTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=alPHgVU6; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="alPHgVU6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754952978; x=1786488978;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=VAPRqcIsJ+W07i2z6ZW4s0UnMr9ipCRg2qmeq2kEwZc=;
  b=alPHgVU6dCK/bfVIYHkSR1e8Pe0WQs3LQugah1R1F1wxmKWJ0jbT86Sv
   x5p8oad1Bf9ihFj2qRSVAWvJeS7zGq2AhbAHTkkck4F+F02085woyHTkm
   VFk4XdygR8DGJqouMUbj+LMdd7ozgI3g3UG+M0XM//zwitMIDzJdJkPQI
   qO2p+RdHicvH3NWfIQjIZwr2/EAemaABc+07s5aEX+FfGpMCJY9omiBua
   iDdn3aRDr1npRAA8/HeA+g6k+s1QQLka9Q5qB5oluTmyVfNL8sJJnTddy
   iUy0vXoIsNm8YOXBsvVWlewV/5DSjANvRMmsaU6E8u3JRa+LSIBZtdAnn
   w==;
X-CSE-ConnectionGUID: oIKDoTZlTH2JUupC31LHtg==
X-CSE-MsgGUID: lUwY9fVBSXq0D/GZkzz79w==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="67817555"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="67817555"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 15:56:17 -0700
X-CSE-ConnectionGUID: WcF9Rv9jS7q3J+VEzntmDQ==
X-CSE-MsgGUID: WhVCN65MTDabMocGYd2o/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166832595"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 15:56:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 15:56:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 15:56:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 15:56:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmP9eDOwY44WptwVbM5pE6TSG+8ytrzIjbAAMvRC64+JloG/tLTMPx+g88rLe5IrHl7W0F3Y+Q6mc4cvnx+HIccmK8FoiyDAE/Ode+xeoSNsgLVQNu/nOkwedjdbBuVqKMtBuleRaqx8d9WETXfjWaoN2aWM1yZA/2UF4LVtrsx8nSF6OjlU8l9HcBvoH5AWM+cFhj461Ri0S//7wavGPpxrA21M9mZJKzRTXhtAJx+hj7IoC7bk4paa2CxdyRtgolz5AJ38vBI/mXSFp7o4ei9lVXDZGmyysdEQVEaZ+qFXjuzXA5B8+kAY7rPPvnwuEbU8M1B4h1NRrmJFsIFfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOszoQ1lz14azgY5g9hRgOoIshS7DnNPCpPrtKlk1eo=;
 b=bi23PlfwIuYS/QKpbmpghCAIE0QQ/3WOY8SU6/IyBKMjWTtLcksPVp2BAGhIZY7XPROPJ7TokcSAuv0++Rz+Vh0hEU0qlvjxepl7X6pGeOiSb48N6DSh6Xn06fuIFVC0QM9G6PLe8IxTPkKVmMr2HoFwt9n4Pv+Yxbk5DFyCw2F+uaxtWkVMxwWoHZUuf1RPRIFDcdL9NYUyWjZlbDKQ1a67RDTNng85yJvNN/zLa8FC7oFOcZafuz6WfBg/Gxpr0Qk54NzIKIUv5Gq94bYZja9QnQ7jvt53CsPBLteqNR8Dn11jMlid4/pFaCqhB6QbwaIpYI/DTEYPvxw3t5JnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7090.namprd11.prod.outlook.com (2603:10b6:806:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 22:56:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 22:56:13 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 11 Aug 2025 15:56:10 -0700
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Message-ID: <689a750ad41b2_50ce10064@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <aJKH4PlYXSuBua4_@smile.fi.intel.com>
References: <20250804220955.1453135-1-dan.j.williams@intel.com>
 <aJKH4PlYXSuBua4_@smile.fi.intel.com>
Subject: Re: [PATCH] cleanup: Fix unused guard error function with
 DEFINE_CLASS_IS_COND_GUARD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0065.prod.exchangelabs.com (2603:10b6:a03:94::42)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c23a2df-8c63-4989-4cae-08ddd92a4518
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVFlSVBneU0ybmdic3p5VUxQZG1FQU9WT3BMYVJuZEZQZVpDTXhRak0wL2xZ?=
 =?utf-8?B?NENxaUdBdDNCY0k5ZGhRVnNzTXc1ZHpwWElDWVJ6SXNEMzZxTnJEUDVhdW5a?=
 =?utf-8?B?MHAyK3Iwb3M5bkF4ejJOOWNuSFQxZEJEQTd6RHZVL0xvSjJJVUt5R3E2OFVl?=
 =?utf-8?B?dzludm8yRHhlVFN3YkpPRU9Yd3hLUXo4dnVnc1BDMTAzK3oxUjF4VndzZVhW?=
 =?utf-8?B?aHphYnhTMlpraE4wTUV2d2tVUFZTckJZNjhMTTRWV2JMWnB5dm5ZbUNjdlp4?=
 =?utf-8?B?dnV6a29BVkRMWkVLcTFSUUszOW53LzF4cUM4QzVJQzdEdVVBWU45ektqeWNU?=
 =?utf-8?B?ams3QW5kamVvTkF6WGdLZlRsWjg1MU13OWU5RTlscGJOWFFPWUw2ekNrZXBh?=
 =?utf-8?B?T3FuM1lHaWhReW1Lb0hXdGFHMnQxbC9RZGZKVENoVTlZV0MwVlRlMnVtZW5Q?=
 =?utf-8?B?TEhFUEFJQW1tWXQ1NjlpNTkvV21xSUFPK1pLQTE5dy9FU0c4VnZXckRUeEZv?=
 =?utf-8?B?Y1FFTVJnRnJ4VFZzc1RaSGMxNU9QeHl0RHhBcURPQ215WFhWY3lVd0xURHo0?=
 =?utf-8?B?REgvdGhheWJwRytUUGl5bldhWnpEbDVsLzlTSnMyeTVOTGJNcTdNdWcyY3lU?=
 =?utf-8?B?REZEM0JHSFlwSm5pVHVkRVQ0VGp0Tm8ya01QNHpwcmpHT1lpZXBlaUhlb0ZU?=
 =?utf-8?B?STlRcVRLUFYwWW9FTTFTd01VMzBtSWsvb3V1REo0b2treVF3QXZnUTNRY01X?=
 =?utf-8?B?QnArcUd0MjAxRVBJMkpYSUhZTUgrZy9pN3MraFR1T0xNRy8zbGVZSlR6eFkx?=
 =?utf-8?B?bGtrTHVJWGkyNTVhQjlOS2VoUEs4UFY2STUwS1YrcVRnRW9pS1NveGhibXFk?=
 =?utf-8?B?SS9LQmZKOCtNUnp2bUgrQmc1MDBBbVdacVdINWx1TmhJMC9qOWhmaVJ5cEZP?=
 =?utf-8?B?U2lHZm1Mb0RjdHVDMUcybExkM1lmNnBkNmhKVVZac3VvY3R3SFI4cXRRTVF4?=
 =?utf-8?B?aU94RnVuajRDbXE2M2ZqQnBjRTBjV2RrNHFJUFBhL0JFT3RoOTcyOXB2dThH?=
 =?utf-8?B?d2pNR1IyOTRJeENwQ1F6a09CZk83NlB1T2tMV2hhbkd5SC84cndZTk52cWt3?=
 =?utf-8?B?YVdKVjlKcDV5dVdRVjVrSUZ0RW9iR2pEK2FhYjRCalBWV0cvN1VKSERXQkZz?=
 =?utf-8?B?RE5mV0lrYXNyTHQ2VFQwRUM2a2lBTTNnNjJDV3JTcDB2V3kzS1VndmErVTJ1?=
 =?utf-8?B?dms1N3NOSGprNTduQi9saElRK2c0amVpaFdpZzFUdk1XMXJEZHJXaGNlNkd3?=
 =?utf-8?B?Y1lIWWhmYTkyTWd5bEUyeFpVV1J0cVlOb2lIZjg0Q3Bzd2JrcHBaVkFUZHJl?=
 =?utf-8?B?SnBjRVpBcTVOL3d0ME1OZmNjNmRNYmoyU2RFcEY2RjNMSjRocVBRTjJHZDZL?=
 =?utf-8?B?cTFKYXE4SFhqTE5PTTJSSkNvK2FlOGEySWN5T2cxMTBmUThGL2tadlM4amNS?=
 =?utf-8?B?ZGRjakN5Z2tqbzU3YUR6QVN6Zzgza0RDMmxkRi90SnhLeU1zMXd1ampZK2Y4?=
 =?utf-8?B?UjJoWFp3TXBRMDREcUt3K3Rpa3FXRFQyTEVwV3AvNUhFY1NnM2o0ZmhWRFZ4?=
 =?utf-8?B?SytETXlHWXhidllZc2VVZytnWlh2TTI3RVBseXArTzQ4MmlpVk55N2dWUXdr?=
 =?utf-8?B?TUNTZ0NpdFVFRDNzZjVTMG8raWxJdnVGT3VQZVc1ZUJ2cjlDQTZlNUM5VlVQ?=
 =?utf-8?B?dDhkV0F6SUVUbVorRzFtOUZ0Q1A2emhOczM2c2xKaHpNUGROV3huSTNTa0VQ?=
 =?utf-8?B?VmovR1h3MXBzY0JSN3hUNDh5YW0ya3l3SUZpd3NXK1ZMK29mOWJ1UndnM3E3?=
 =?utf-8?B?d3RVcmZzZmcxU3JYdmhwczBqdDVzSDVyTk5DYWs0UThBN0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUMyOHVURmdBWHM0b0syZ3MzZkoxYWNBZzFleFNVaXAwaFJlS0NSOVhFQmw3?=
 =?utf-8?B?TWFEZWxsU05DVXRiZHBUNWx5KzBvQ0NRT09weFcrNElVMEptbUZmR0hPQ3Ev?=
 =?utf-8?B?SS9KbWQ2L3o1K1QwKzVCb2sveVRkekNNTEJuQ0hSRCs1TlhreWJBTi9PYkN1?=
 =?utf-8?B?aGZnUmdkMU5uOE5QVHBHck15MDRoRUhyeEVLanlORHJoWHRBbDdpR2QrSmpm?=
 =?utf-8?B?QUNYMG9teXBaWWVLZmVTSHV2VzhQbGxJVFZORS9WZXBqcmJkWXFnVUtBWkJG?=
 =?utf-8?B?OUxFQ2VUWVNML000aWNNdG9nUU1aUXpTNC9yc25ZSmRGUlZPdWVsR1F3UHRt?=
 =?utf-8?B?THV4cXdNYWVJcHhUNTZCbThqOVpRU1dXL1M0dHJra200RW5CMjJpWUppR2tz?=
 =?utf-8?B?Sk1mbHk2S0c5WTl2YUZZT2hnK29oTlA4VDI0ZFJsV2MrdTJUSnVlSzRiQWlI?=
 =?utf-8?B?ak9WNWgzRFBsU05xR2JpazVUQmd4dHFRZ3ZDTmhSK2hYMStmUXVEczdrc21W?=
 =?utf-8?B?ZUlOeEkrYWNCV0p5MGNiY3pKSGRKcFpkRmF6TE43NzNVMVhydFdiOVJodDdp?=
 =?utf-8?B?RjNoYW41cGs1Sy9VMVlrcFI0ZFYyWVN6UVZHV1RPUldJc0hxWDVzc0lFYUNl?=
 =?utf-8?B?RmQzb2hFMHphenR2ZVFBVWEza0ttWGFtZC9wSzNxWG0yTnloMGJPWU1seVk5?=
 =?utf-8?B?d3Q1SzJmTEwwd0dJQlRlaXVYOEpSUkNQZmJQZ2NQWHZmQ09JeDFUaHhxTVda?=
 =?utf-8?B?c29tbE9EV0lFV0JGZjJoVnBmRk02RU5LRitodGxhQmk4QURCYmtIVk9Pb3c5?=
 =?utf-8?B?ZEJYbEhvalVvWWhrd2ZXbkFXT0tJVDFha0ZFdlpHL1VWU1lsQkJ0Ri9aTVJT?=
 =?utf-8?B?bHlaMEg0eHhWU2lCc0dTemdKaFlLRTlKZ0pMLzVGZHFCek9LNDVaV2VFY3U0?=
 =?utf-8?B?dGNjUGpwY21Fd3hUcm53V01aZHUxaWswTnBUS055MGgxcWpZQnQ4R01FcGNU?=
 =?utf-8?B?T2RTNXM0cXBEOGw1ZWFUMlg2L0FpSDV6bnlGeVVGNmQyZFJVL3FnMXA5aXFy?=
 =?utf-8?B?cFZGZXdWa21TRURwaldieVhkRm1UbUwyVjJnYmQyNXpqM3hpcEtDRWNwU3cw?=
 =?utf-8?B?RGVzKzQyM1ZQdmR1VnlGYVROeUJyWmVvd08rS0hTUmNydW52bTdiV1ZDbkY5?=
 =?utf-8?B?V3pYd25JTURwMzhGWGFPanl3YStKYWh2c3NqdmZRa1piOWxaNVZYVEphM2Fv?=
 =?utf-8?B?R2llNjRRekhGQUlKYUVxclB1UlRBRlgwNUNWWXljcklTMTg0SUllUW90MGNu?=
 =?utf-8?B?YXZRS1lBMXBTbmxWUEJ2RlhLc1M0UG0rZVV6YWZNQmtYdzZyck9Venp0azVG?=
 =?utf-8?B?QjZKL0k4b3lTSTZXRWkrTm1Xd1RzcFJHdUVSNjNTKzc0QUhtdG9LcVVrdFY1?=
 =?utf-8?B?dmU4cHZ1ZHVnT0tLVTJSZmp3MnliWDRGU1lwOVFRVUdGVEtjSGNhYS9HZlgy?=
 =?utf-8?B?L3dlUTVka0lvNU1PUk5EVVh1Mm9GdUU1UXlnKzdFVEJBRmN4Zmx1TUw5cVc3?=
 =?utf-8?B?WFAwTEVDZ0FyNGNIUzY5cVZxRWp6cEVqV2hOQXk0YVJ6VkNJcVBlY3VxNFVq?=
 =?utf-8?B?Y09tUDdkbkU2Q25ITGo0bWQxN1hvem54K2RyRkN2KzlzN2FzS1pJUUZtSFdj?=
 =?utf-8?B?d2dwamFEb3FJczVNZXZhR2lZUEhLekJ4OE8xbVpZbWxoWndHd002RThBemhr?=
 =?utf-8?B?T0p1Vlk0YjZCMWZkazdqeHJ2Y0VIZmtJRzBDd0pvZnFwMG12V1lqTzZVNHFR?=
 =?utf-8?B?SW94aCtYdHlCUHRkYzBTcXh2cTRkWGxOQmdNbFNmSkJ1d2hxbmdUdVRxN2dG?=
 =?utf-8?B?MWZDdDd6YlVyd3ZrWmtLUnFXaS9xaWU1MVY3RENuVFBvcWFwT2tlQXB0UXZh?=
 =?utf-8?B?dU1XRTVyZzVuUGpiN21SSmJybjAvV0Nha2U3TjIybGxXN3Y3MlB2cVU5ZTRh?=
 =?utf-8?B?Z0RoZWRkeXM2RElmWnU3Vjc2VlRtaHFaT2t6VUZZWUVTeGlRQk80MFVLYnVL?=
 =?utf-8?B?QmtKYkllNnBGR1JzUDNlN0gzclFFVGZDdms3MUhUNnhPcTlaK1N0Y0xySThP?=
 =?utf-8?B?RXE2RFlackNUZExrTlFIaEtVUEgrUFVWSVF2alRBWVVSTXJjL0tuQzBSRWxq?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c23a2df-8c63-4989-4cae-08ddd92a4518
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 22:56:13.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcr/EMV0wK1UxzHO/n6ZnOjSqB+Cyef4I5sYPCD7Olb3Td38qmPtdr2LiSd6fFr/mlXMCJU/7rXsw1AA7QdTQ6tRj55OqYKe0pqeEUpguIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7090
X-OriginatorOrg: intel.com

Andy Shevchenko wrote:
> On Mon, Aug 04, 2025 at 03:09:54PM -0700, Dan Williams wrote:
> > Andy reports that the "lock_timer" scheme in kernel/time/posix-timers.c,
> > with its custom usage of DEFINE_CLASS_IS_COND_GUARD(), results in:
> > 
> > kernel/time/posix-timers.c:89:1: error: unused function 'class_lock_timer_lock_err' [-Werror,-Wunused-function]
> >    89 | DEFINE_CLASS_IS_COND_GUARD(lock_timer);
> > 
> > ...with a clang W=1 build. Per Nathan, clang catches unused "static inline"
> > functions in C files since commit 6863f5643dd7 ("kbuild: allow Clang to
> > find unused static inline functions for W=1 build").
> > 
> > There are 2 ways to solve this, either mark the class_##_lock_err()
> > function as __maybe_unused, or make sure class_##_lock_err() *is* used /
> > gets called to disposition the lock status.
> > 
> > At present __lock_timer() only indicates failure with a NULL __guard_ptr().
> > However, one could imagine that __lock_timer(), or some other custom
> > conditional locking primitive, wants to pass an ERR_PTR() to indicate the
> > reason for the lock acquisition failure.
> > 
> > Update __scoped_cond_guard() to check for ERR_PTR() in addition to NULL
> > @scope values. This allows __lock_timer(), or another open coded
> > DEFINE_CLASS_IS_COND_GUARD() user, to switch to passing an ERR_PTR() in the
> > future. In the meantime, this just silences the warning.
> 
> Hmm... It seems fixes the timer case, but left others still fail:
> 
> drivers/pwm/core.c:54:1: error: unused function 'class_pwmchip_lock_err' [-Werror,-Wunused-function]
>    54 | DEFINE_GUARD(pwmchip, struct pwm_chip *, pwmchip_lock(_T), pwmchip_unlock(_T))
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/cleanup.h:380:2: note: expanded from macro 'DEFINE_GUARD'
>   380 |         DEFINE_CLASS_IS_GUARD(_name)
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/cleanup.h:372:2: note: expanded from macro 'DEFINE_CLASS_IS_GUARD'
>   372 |         __DEFINE_GUARD_LOCK_PTR(_name, _T)
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/cleanup.h:358:20: note: expanded from macro '__DEFINE_GUARD_LOCK_PTR'
>   358 |         static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~
> <scratch space>:81:1: note: expanded from here
>    81 | class_pwmchip_lock_err
>       | ^~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.

Ok, so in these cases where the guard is unconditional, the _lock_err()
method can be safely ignored. Here is a quick patch (below), only gcc
compile tested, that tries to quiet the warning for unconditional
guards, but keep the warning for conditional guards.

If you have some time to try it out, great, otherwise I will circle back
with a clang W=1 compile test before submitting the formal patch:

-- 8< --
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index d8e7d1e5561b..4f5b719d0117 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -347,26 +347,30 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 			_ptr = NULL;                                        \
 		}                                                           \
 		return _ptr;                                                \
-	}                                                                   \
-	static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
-	{                                                                   \
-		long _rc = (__force unsigned long)*(_exp);                  \
-		if (!_rc) {                                                 \
-			_rc = -EBUSY;                                       \
-		}                                                           \
-		if (!IS_ERR_VALUE(_rc)) {                                   \
-			_rc = 0;                                            \
-		}                                                           \
-		return _rc;                                                 \
+	}
+
+#define __DEFINE_GUARD_LOCK_ERR(_name, _exp, _attr)                      \
+	static _attr int class_##_name##_lock_err(class_##_name##_t *_T) \
+	{                                                                \
+		long _rc = (__force unsigned long)*(_exp);               \
+		if (!_rc) {                                              \
+			_rc = -EBUSY;                                    \
+		}                                                        \
+		if (!IS_ERR_VALUE(_rc)) {                                \
+			_rc = 0;                                         \
+		}                                                        \
+		return _rc;                                              \
 	}
 
 #define DEFINE_CLASS_IS_GUARD(_name) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name, false); \
-	__DEFINE_GUARD_LOCK_PTR(_name, _T)
+	__DEFINE_GUARD_LOCK_PTR(_name, _T) \
+	__DEFINE_GUARD_LOCK_ERR(_name, _T, __maybe_unused)
 
 #define DEFINE_CLASS_IS_COND_GUARD(_name) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name, true); \
-	__DEFINE_GUARD_LOCK_PTR(_name, _T)
+	__DEFINE_GUARD_LOCK_PTR(_name, _T) \
+	__DEFINE_GUARD_LOCK_ERR(_name, _T, inline)
 
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
 	DEFINE_CLASS(_name, _type, if (!__GUARD_IS_ERR(_T)) { _unlock; }, ({ _lock; _T; }), _type _T); \
@@ -465,7 +469,8 @@ static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 	if (!__GUARD_IS_ERR(_T->lock)) { _unlock; }			\
 }									\
 									\
-__DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
+__DEFINE_GUARD_LOCK_PTR(_name, &_T->lock) \
+__DEFINE_GUARD_LOCK_ERR(_name, &_T->lock, __maybe_unused)
 
 #define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
 static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
