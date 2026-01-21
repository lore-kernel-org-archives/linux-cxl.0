Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5036826A;
	Wed, 21 Jan 2026 22:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033375; cv=fail; b=cSxVBsVGndvfdsdbhAGG8tU/MNcl6Y4Z+BY7RXgWH0OFOhvz1vuTjIyuTulHW47VPr+ZdYe/2LZry2lnsamlFwmQnwXCFtLGaCJucBUBgEft5U2OqBlyDOUpzpcM1BBNljG0u3sLbicb9aQIQG3rT+XHBoUZ04MECxqiuJI03WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033375; c=relaxed/simple;
	bh=uzZ0AMfPWq48bwabFKXVmb8xmdpZPKfoZNiRlHtzloU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=MY1ew22cQib9xZeTkVNjWxqSAgOaBf+Dm3TWrFTk/xtfn8s+x0sVp4o4vXR49o7kjgaV55FYcvvA4ax6QaQ4PEHmDrkxvBXk9LYruxCere0MqeKQy0TMTZDjiutQQSC52GBIyomZlsPnHMuNPLbqqsGy/2RbU5taNRACy4ymXBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EB3g1MB1; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EB3g1MB1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769033372; x=1800569372;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=uzZ0AMfPWq48bwabFKXVmb8xmdpZPKfoZNiRlHtzloU=;
  b=EB3g1MB1gp0T8R3HMPw3St6u6OJi8dBVS1hSbBnY85oHTN5u82/3jrjX
   n+++kTeaHscQe/2MlDwGw/GDQzNVB79ZsV6hLYZ27RhJ2JdOxIAtUp5is
   EsPG+9vxBtKtvSRy+PJkYAdYE470pwbOwApXySSFUrA3Z36AUveOSAlP4
   C3kM4JBCamRWjMgCp5SJki79A/yX5zkkRVZhSDQ++kPHOGP0dSy8B18Dn
   bmuyU7SvUGV1fiLU3rQGSZt7btN0r2hwNO3brfJ+ITKdLKbYFGMRfJcs3
   5grabctgRDBJlsqkVo/wmBwBuTsPT1OCbPHi3YEk8k89X86Kb1oKgElYz
   w==;
X-CSE-ConnectionGUID: rarVljZoQ46gJm4Ub50GNA==
X-CSE-MsgGUID: kWTi+HkGQhibVbpdMSeQ2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70363884"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="70363884"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 14:09:31 -0800
X-CSE-ConnectionGUID: vNHajyycTkOZfqp811kl3g==
X-CSE-MsgGUID: FsKUMo+TRIO5SdaMBsEMHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="211069077"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 14:09:31 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 14:09:30 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 14:09:30 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.26)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 14:09:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJ8w7V7ikSuUHk71wSL0Ma4zygpeAVlxcNcZcji2eKZOla6IwvDlpCWLPW6XiMiV85jby46KMKAq0Gv/LDKpjAPlmQP8Lcw6IN4w7J2mWXlMZiULOlpx6CyxFgQ2PfRAMb/MbViRQtwZOrDR0nMJUD8HcDEu65omHFXXHXD+LY+x3Te5ZyGE2BviBgMQYs4I3p7011tW9RCEI7VIhI8z9uaq6WivaHwhJVIb9Y/dmDK7hrKXo3TFi9xTob1XoYIiRKZQopWsaPxzylgA2eJkh3l21cOHi/PgeoQ8Cyp9qNTSXI3u5FWsH1fQjMLE/QrJCgzx1Vw/3uuEA2XArI5v5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZkCdxD8lWrKgo0nS/7MNGN0fgQ/hxsYZ3GbvXBp+fc=;
 b=ZlrKwaMt/JeQ21FGLd/nuNRmsEIwS5o33Vsb71YycX5LOY9BcjuFv8cKoQXx/o8Jq72IvbFc9AGV1/K5tn10m1X/y/AUu1uuWPC5EycfiM3W8wDWfOT47n+UgWSF3Kfb/4Tod21s1zKkxVkZxeP8TCEIGo09lqpaXeIGPlmXXuKtdgUq9Zkyjw5wM/XmdE2BdsSTfaQ9daOAZxnPH17zZO4xfCwQvpfmWnGEd2mzvWHs8SebfwzG5pkV6UMhWAeYiNBTWkY9/RX2n+oMdNRtyYeMEC4bx6mCwoKFnF1QLBWmlKwuYnlBJMhX0nHVKCDOYht0zXzYRXSsG87vsipuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8537.namprd11.prod.outlook.com (2603:10b6:a03:56f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:09:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 22:09:28 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 21 Jan 2026 14:09:27 -0800
To: Yazen Ghannam <yazen.ghannam@amd.com>, <dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, Peter Zijlstra <peterz@infradead.org>,
	Dave Jiang <dave.jiang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Borislav Petkov <bp@alien8.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, John Allen
	<john.allen@amd.com>
Message-ID: <69714e9728d2d_1d6f10075@dwillia2-mobl4.notmuch>
In-Reply-To: <20260121145817.GB1784626@yaz-khff2.amd.com>
References: <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
 <aWehZwXsK1IXRNU2@rric.localdomain>
 <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
 <20260114180859.00004623@huawei.com>
 <20260115080444.GD830755@noisy.programming.kicks-ass.net>
 <CAMj1kXENYZq-UkCup6FSH_4tmpRe4xJN1_veuSWs-hxxAo=1Ew@mail.gmail.com>
 <20260116143838.GC1890602@noisy.programming.kicks-ass.net>
 <aW5AvfcjLkSP2j42@rric.localdomain>
 <20260119160342.GA659351@yaz-khff2.amd.com>
 <69701f6de978_1d6f1001e@dwillia2-mobl4.notmuch>
 <20260121145817.GB1784626@yaz-khff2.amd.com>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:217::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: e97e636a-4ca5-4562-120d-08de5939beeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L29IdXNXZDVadFM4Rnkwc3VxMWx6M2F5RE5USUphNDhBOCtsNS9sSWsxNDlX?=
 =?utf-8?B?R0M5UE12UStkVi9kL2RvMmR2MngyczdNUjVCV2laQUhKcXUrbm51TkhEMms0?=
 =?utf-8?B?a2JTWmw3T0x6ZVhLMWV4QzVFeTVURjJZN2E5NWtoaUhLV0c1RVFsRHdMNGNr?=
 =?utf-8?B?RUYzQXN2eVpicWFoWHRydFZxNVRPVHRxRnluYXllNjBBc0xkWFJINkhBT2Vr?=
 =?utf-8?B?eXRIdmo1MmU4ckVYUU5JMGx0WFdGNnRQTmFSUHRFaXVzYkE4V3l4aVRTZnAx?=
 =?utf-8?B?THN2Nk9hWTNxSEFHNnZpSElDL1JHY0N1SENCc2hxYVQ1cjRHRWdyTXZUd2x6?=
 =?utf-8?B?R2ozb1UwY0tkRjRjVFJlZ2x0KzBTZmJ5dTh1S2YvY1J6ZE53VnVXdEw3Tk5P?=
 =?utf-8?B?UG1pczVWZzJtbk5BeHdMMktkVTNFcVdFQURnYUM1SE5mRjN5RzloVTZ0eFV0?=
 =?utf-8?B?Vi9JSnFiNmN0dzBxMkpWZFlYbklRYTc4OWVuOWVMR1kvZDhDTWlQd1d4eUpY?=
 =?utf-8?B?RjVROUpVb2JNMUFnOFFhbXdVdzZ3ZFRUNmhQbGxYY2YrT1o0b0lCcTJFOHNV?=
 =?utf-8?B?WmhrOXZ5ZGltSVhqYW1IZ3ZqR2VDak1zRWtXbXdjZUFIUXJlb1VqNEV2aDdD?=
 =?utf-8?B?dUZyS2lLQ2FuSDZzZGFKQ2h1Q1BIYkRESkpLRVZIMnpCTU9PNDRDb3MwY0hs?=
 =?utf-8?B?MGwyK3hOTExXcDk0SlpXdW4zQ3lDYlNCV3ZUWlJYYUM3c2luK05WQ1dsdEs0?=
 =?utf-8?B?N2hFOWVjdFpPakRWSWpuTlM1L0JSclJYMW90Z1dyRGxBd2xHcURYNnU2WGdv?=
 =?utf-8?B?TGNob1UxWnhWYm1lZmpoZDZHeWxjNDRvTmM3b0JQZFMxaFRPeDFpbzRhWi84?=
 =?utf-8?B?NFQxQTNIMGNzWWtralhPTW5nanJzZ1lMbGdWOS8xSTVzRlE0a05KUW4zTHhT?=
 =?utf-8?B?TnR1SjU3SGZhVitZUm5YcmFDaEJnL3l0UVdhSDdnWjkzWER6R2tIWFI4VlFV?=
 =?utf-8?B?Z3gzUi9GdEowNWVxYnRqV0V2bmVUdGJyK05Ed0YxVkxhd2lSSDExdnkyWUhi?=
 =?utf-8?B?Q29BQ2ljQnB1MXFmZHFaQTlER1Zjc0pVSjlUd09lT1NISjdlZGxPWWYzWjEy?=
 =?utf-8?B?RkhJeWxsd0tIb212WlhOM1c0K0YrVkFNc053NUV6WlpiRHA0OTZPWFY4Tmtv?=
 =?utf-8?B?L05tZG1wS3RFVmxqUzkxRW1HNVRMMWpreDZDMlVEUzNkc3NZUzkrSCtvQkNB?=
 =?utf-8?B?eXlRYmFPeS9BNDJKbGJkWDRqRUtDVUJRUGhGajViZjRoRTJXdFZFeFFsdE5v?=
 =?utf-8?B?U0VMZmlBMnMyQkFBVEJCKytta2UwWkVHSjRQTUxqRFFuMHVobkZ0Tlk1eERR?=
 =?utf-8?B?VTdBYnFnU29Td2YveDhKSE1PTmVoNTlhcHRQdTlxM3FWSDM5QU1GUUd0WVhR?=
 =?utf-8?B?c2w1eC8xRFk3SkxiTGZLWkVybVFGZ1dxKytJS2JQSE5HWnFWVGdWQkUvU21U?=
 =?utf-8?B?RFJka3JMZjRYamwzQjI4YUhVRTB0QjFyMmFUZS9HaHNYQ2F5L21PWDF5cTVQ?=
 =?utf-8?B?RHJ6NkZmTzJlUmg1Q2JHQTBLS242MGV1OTFWbkZVS3ZQaDFMeVBRWkt3L2t4?=
 =?utf-8?B?Y1pIRnJuTUI4c2tJT05tbFZpNzhaTkZxaFhob1g5VG1wTW43MnhNOGpGWUZl?=
 =?utf-8?B?RjdRVE1CVks2VUJLSjlsbnRMOHJ4VlcvN1UwaU1oY1JURmJJZTBpWkZZUjZ3?=
 =?utf-8?B?YUlsbWxJQnVXVFJaNkxNNk9XUk1RbnBOUnZXWTBpdGF6N0UxSFlmNktzdHND?=
 =?utf-8?B?RVJSM2tpUUNVYks3Rm5jSzlkVFhaSll1Zk9nR2hHVEt1dWovSTB4bU1MNnly?=
 =?utf-8?B?ZGszMHhWM1QrWmNOR0lucVhTTHNJek83RWFZaVdZcGdNYzROdXJ2Q2krSXRo?=
 =?utf-8?B?d1RoWkJ2cUZMdTNUdFBkd3FKTGh0QTFPeEVJVFVDamxXRGRVOUFiZDd0Umd2?=
 =?utf-8?B?WEsxYVplRCtuL04rT050RjJaRDNxT3drL2ZyRm5qdEtLZUhReTlKNVFtMnZm?=
 =?utf-8?B?djVoc1ZkSTNRQkhoUHBZSU9NUzd4UHk4Z09EYmJVMnRQMjI3Ry9hRXBPYldO?=
 =?utf-8?Q?Nxag=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW1MSHdnSkFLcHdsTVhoNFVKTm5xUkF3OExWR0Yvck5UT21XbTRxL3QxTXp2?=
 =?utf-8?B?cURITXNsMGZiWHRoTzhmV2xWcjNKRmRmc1hOYVhhY01ndU1pVGJqSThXOGU0?=
 =?utf-8?B?NHF4YS92a1NOYUFHaklYanZOQnNXWkl4VHJoYmJLNG10NGhGY2VzM0tNSTBM?=
 =?utf-8?B?WnlaVCszNEdpRmdKQXlOWG40T3IrWktRRUxlVVRFQXlZQ3B2Y1pJRnFJeDlq?=
 =?utf-8?B?b1JsYnEycWRFR3k5T0FpMDV3akc1d0M5dlE4SlA5Ly80d3g2cFNqUzBuQ3JU?=
 =?utf-8?B?bER2NnQvdGlZend1SlFMM3hzeWZ5cU1ncEEwRDJKRVdZUHdvckpzYStZa2FR?=
 =?utf-8?B?cjlWUnA5YXBmZGFTRUFxUlBsa3FDZEVZZXM0TkVlOVhNT0dqUCtrNlB1TEpO?=
 =?utf-8?B?NFo0SmxCRUNpcTJqRjF2WlJYdFVZaUxpQzJPc0tSdkpNcmtIYjJ5RnkwUEQx?=
 =?utf-8?B?OHEwSHd4Mm5CdW14RThNNWFpS3B4MFZiQUExSjBzaDFleGYxNUUwY253ZFJY?=
 =?utf-8?B?N2htV1Fmd2dGc0o4REZNYWljbEwrNFovUVMyb09vOXFXbmhGYi82dHlPbXd1?=
 =?utf-8?B?R1BSeUt0Z3NxNkZiaXBneFRSa0VybFpmRDh5by96ekhHTjFqSFZNcUpNcHk0?=
 =?utf-8?B?dlc2OHpTTEZxaldlUGhIbE1QLzhSRFpHbFdJZCtmcHQ5ZFUxanIyODRWM1RE?=
 =?utf-8?B?RENWOWFkRHhJYkx4NmhDTTNmdS9HbjNaWG1EVXh6WDNjbjJubERyYXlQbWFa?=
 =?utf-8?B?c3pBdnZ0RGxQS0cycVlqdUFNRVQyL3Q1aXJHN0ZZRWxZTE5FN3hDYlUyVEV1?=
 =?utf-8?B?Q29sWmhBL215WHZWcUtRV25RMVhWWllJY0ZZeHhpNGNUeDVERThFWXZPbjFv?=
 =?utf-8?B?b3BMNHlEa2FCNVFTNWthcmcxYmUwdFZFdkE1YjhyZGJvNThCUDArc1c4RjBL?=
 =?utf-8?B?MEhjNzBCVWVydEZLRHZObG1jUU1ZY2k0enViZlpLOUwzR3VjUkhRZGY3QkJt?=
 =?utf-8?B?NHdkTmFzUVlsSk5YcVg4YnBoMGhycUJLTFVDa3hKY0VQUENjbDF6a2FiVDlL?=
 =?utf-8?B?eDM0UHBnc1pyWi93NzF2T2JDb3BEcjFEcFJIL3FWY1d0SlhXZVowRDFBSDAr?=
 =?utf-8?B?V3RTUmFmMFBlcHVwVWluMUpXU0JkT2dBT1BhSTV3cC9JWWk2MVBrOXM1Slhj?=
 =?utf-8?B?TjJiYzQreVJhcm5hVWYzUmcxL01WSEgxek1XbUg2Qjh4RHBZZXBjR0hodlNl?=
 =?utf-8?B?aEI0bHowVE90cndBdDBkU1hFWjlvamRTdFJUQ2xVMzltUCt6YmxLSEtYOC9x?=
 =?utf-8?B?U2VKTDNFRWRNSUJZYU9JNkNseHF5OVJoYXhJV0p5M1FIQ3JldWRyc2xwZHFP?=
 =?utf-8?B?NXpZL1ArK0ZnNmliU3JoWEthVTJESFRrSkRMQmVmcExidmVublRiSGdsOFZl?=
 =?utf-8?B?MXNZOXNVUE9KaFlGaHYwN2d4anlJZDdyWUM4b3o5Z3gyU3paOERVanlualBt?=
 =?utf-8?B?SXAxeEVXb0NlbHQ1Ukd1aTdRYzRaVGQ5RUtLZ3BtSE5qVk02WTVES25VUk9u?=
 =?utf-8?B?RmVtTVV2NnAwU1lOakZKTDZoeTZIZVZNa3ZSb2M2SVpQSkJZWlpnaUkza2s5?=
 =?utf-8?B?RFhTU2N2RTlFZ2wwOUhGZ2IvanFrVUtsNU4xeWIvWkpTWFdvd21sL0RrUVY1?=
 =?utf-8?B?Vi9hVjFrbmZtKzdKb1I3eC9HdTQwSThHU3pTTUg3VW81dVRUejl0RUdUTlpG?=
 =?utf-8?B?SGtnTm9QaTMreHpjWjRUOUk2anBsTWdkTGhpcHRzUWplNktjb0EyZEJITjBM?=
 =?utf-8?B?V25OcTJDSVBmbStKeFh4S2dHODlwbFZNVkN6RThqcGI2amR6ekFvdG05eHdD?=
 =?utf-8?B?bTNJN3E3cGhxUjlyOFdBeXFlSjl4cUFVTm9SYkNRdUZQUFNNS2pOdnpkRlox?=
 =?utf-8?B?b21nc1Mrd1kzcVF4SGtGd0xZQmN2eTlic2V6WEJtUzlBZjhWMkdYMm9oMk90?=
 =?utf-8?B?bVdubzBqQlh3bXV3bDlMZHRTT3JhamR6QmROR0J3bnpjL2ZuOXlDOVJLQmJF?=
 =?utf-8?B?c3RFWkhoZkpjWW5VOG9ReFp2eHhhU3dRN3JCZk5BUC9YQWw0QklHcURmbFR5?=
 =?utf-8?B?S0V0VG9EaFBBVEhwYktiVDd0T2pHalhNcy81dkxsYWVxL1ZiNW0zNmZjczhB?=
 =?utf-8?B?ZE80UkJLaUxqYUZEYjh1Sjd1MGRINmo3U09ULzJROEU5L3FPa2l6dmdrZ0dO?=
 =?utf-8?B?VWRBdktOU3UxRTk0cWxFU21LSC9ERGpnT2VydjlTN1IwaE5MbTdSVzRnZzYv?=
 =?utf-8?B?UTJLMVhBeE9ZTDFxWkw1SkJFcmx5Yng3aEJoUElaNklTT2l5QlpROEZVTWpJ?=
 =?utf-8?Q?p7WQR+nAJjgzF91k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e97e636a-4ca5-4562-120d-08de5939beeb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:09:28.6262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrtzZFHHeDwMQA3DY9fxiJwb1vWHXaERavebT4i78NAlWYqzpmUu3Hbvz2j7RIKv3XO9Vxt4z698sCnvAY/2/+9s1pYcgJspGmSe5Me5EVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8537
X-OriginatorOrg: intel.com

Yazen Ghannam wrote:
> On Tue, Jan 20, 2026 at 04:35:57PM -0800, dan.j.williams@intel.com wrote:
> > Yazen Ghannam wrote:
> > [..]
> > > Additionally, the same translation code can be used in multiple places
> > > (tools, FW, kernel, etc.). Most consumers treat the code like a library
> > > that they include. It's coded once and bugs can be fixed in one place.
> > > 
> > > However, with a native kernel driver, we have to re-write everything to
> > > match coding style, licensing, etc.
> > > 
> > > Also, new hardware may need changes to the code (sometimes major). So
> > > there's upstream work, backporting (more testing), and so on.
> > > 
> > > See the AMD Address Translation Library at drivers/ras/amd/atl/.
> > 
> > There is more nuance here.
> > 
> > There are indeed cases where there are high degrees of non-architectural
> > details in flux from one product to the next. For example, the details
> > that EDAC no longer needs to chase because the ADXL DSM exists are a
> > solution to the problem of shifting and complicated memory topology
> > details.
> > 
> 
> Right, this is the intended use case. 
> 
> > CXL is a standard that this architecture at issue decided to inject
> > software-model-destroying artificats like CXL-endpoint-HPA to
> > CXL-Host-Bridge-SPA (Normalized Addressing) translation.
> > 
> > A Normalized Address looks like a static offset per host bridge, not a
> > method call round trip to a runtime firmware service.
> > 
> > Note that there are other platforms that break basic HPA-to-SPA
> > assumptions, but those have been handled with native driver support via
> > XOR interleave, and non-CXL-Host-Bridge target updates to the
> > ACPI.CEDT.CFMWS table.
> > 
> 
> I see. So the concern is including model-specific methods that would
> modify the CXL standard flow, correct?

Yes, but more than that, Linux benefits from one vendor's model-specific
feature being upleveled into a standard concept.

With ACPI there is a Code First process to get clarifications and small
features into the specification for situations like this. For CXL we can
only approximate that with documenting "conventions" for shipping
platforms [1]. The request for CXL is document the driver-breaking
platform features in a way that at least gives Linux a way to say "oh,
hey $HW_VENDOR, you seem to be taking the same liberties with the
specification as $OTHER_HW_VENDOR. Please implement it the same way
while working a change to the CXL specification on the backend."

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7ac6612d6b79

As I told Robert, I want a generic "Normalized Address" facility of
which Zen5 is the first user.

> Or, more specifically, is it reliance on external/system-specific
> information?

Reliance on system information is not a problem. ACPI is great at
distilling platform degrees of freedom into static tables and shared
concepts.

> Or the time spent on a round trip call to another service?

No, overhead is not the concern, opaqueness, complexity, and security
implications of sprinkling runtime service calls for what amounts to "do
some limited address math" is the problem. Static tables can carry a
large problem space without all the pitfalls of runtime service calls.
Examples are "CXL XOR Interleave Math Structure" and "Interleave Set
spans non-CXL domains" feature of the ACPI.CEDT

> > > The PRM methods are supposed to be able to be updated at runtime by the
> > > OS. We could think of this as a similar flow to microcode.
> > 
> > No, at the point where runtime updates are needed outside of a BIOS
> > update we have crossed the threshold into Linux actively taking on new
> > maintenance burden to enable hardware platforms to avoid the discipline
> > of architectural solutions.
> > 
> > Microcode is a confined solution space. PRM is unbounded.
> > 
> > Now, stepping back, this specific Zen5 support has been a long time
> > coming. Specifically, there are shipping platforms where Linux is unable
> > to use any of its CXL RAS support because it gets tripped up on this
> > fundamental step. I would like to see exact details on what this PRM
> > handler is doing so that we, linux-cxl community, can make a
> > determination about:
> > 
> >     "yes this algorithm is so tiny and static, PRM not indicated"
> > 
> >     "no, this is complicated and guaranteed to keep shifting product to
> >      product, Linux is better off with a PRM helper"
> > 
> > ...but still merge this PRM call, regardless of the determination. Put
> > the next potential use of PRM on notice that native drivers are required
> > outside of meeting the "complicated + shifting" criteria that indicate
> > PRM.
> 
> I can give a general overview. The AMD CXL address translation flows are
> an extension of the AMD Data Fabric address translation flows.
> Specifically for Zen5, it would be "DF v4.5" with adjustments for CXL.
> 
> The "DF 4.5" translation is upstream in the AMD Address Translation
> Library. See code examples with "git grep -i df4p5".

Right, that looks like all the same complexity that the Intel ADXL DSM
deals with, but ADXL only needs to handle the "complicated + shifting"
nature of product-to-product DRAM architecture changes. CXL address
translation is left to the OS driver because CXL is standardized (can
not shift).

> I would consider this "complicated + shifting". This is true for general
> memory errors reported through MCA/EDAC.
> 
> I defer to my CXL colleagues if the "shifting" criteria applies to
> future CXL systems.

My hypothesis is that it was convenient for $HW_VENDOR to glomm this
small subset of "CXL Normalized Address" into existing firmware method
infrastructure. It did so at the expense of exporting the complexity of
yet one more PRM method call to Linux.

A static table is unplanned work for $HW_VENDOR, comparable of amount of
work for Linux, and lower amount of risk to mitigate from PRM exposure
for Linux.

My goal here is to have an archived message to point to the next time
someone wants to reach for the "PRM" tool and understand that Linux has
a high bar for new invocations.
