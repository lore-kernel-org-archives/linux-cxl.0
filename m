Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819B3566A
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753135931; cv=fail; b=J3tE9ka5SR6d9O+BBZ7XhWa8p2mUW9ckaESVrL3/I1VlR1zjrXq8e8uWoBivfi6nqKEXpnNTi3ZKDKsNp10hyRXk8EgWGhcKTtg4G6fy129GWuKayzWC45ysnterqjckpI3ec46RpCSHPwUEgyxhXpNyjQc3EgH0o1vsL1LdlyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753135931; c=relaxed/simple;
	bh=KHq/YVmqQxt2Z2ScwaCR+Ez5VZAH1xmU2Hl4PthZxPc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=cXEIi7iDhauBGnSY/UEPq+rs6cPOkZbegbWW7cuq87LPFlr5TIktpWZyLtBX+tLd5mhfV2wD+i2X3NEHgv4M78wGMA27WJqJ7z23N9uCZbxWeYQosgs78ze1+pCQAGXJYAT0FSHlbRJi4XRQXGdToflqR3FPFaEcWrR1DKIzEYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zu1SiopJ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zu1SiopJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753135930; x=1784671930;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=KHq/YVmqQxt2Z2ScwaCR+Ez5VZAH1xmU2Hl4PthZxPc=;
  b=Zu1SiopJXLmKIwM/z8feD8xWNwwd6JZLrgP0/MiI2hHfCl99hd2oXXr4
   QAVgSoaiLhUPrkZGorltVlQAcx5N/+T7WcJbg6yDqdaFedDomFh/UWQSN
   k9uuf+NHEpuiMKmyUvaO31qAaBlH2j2BqQ/VBJEAIG8HthYx+EiXBipoK
   mWZOoIhqt60kNlkOwfc5BqBZlU5H9PuyPKGmD1tvYv7M/vCW57QS06eMk
   9RykxbfXttOv0uNZRAd8+CgXYqVogUXWWdMsX7sqKjdF5gfxAe2pylagn
   cax7GQVQ6Hk1z0aaojCrVUNi+cBqP9/tkxBYXSBZusZISV502O4seX3Ic
   g==;
X-CSE-ConnectionGUID: sapUifNASWCVIAy8VGAFHw==
X-CSE-MsgGUID: 8lSVddc9Q6i4dQJn6eWitw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="59182607"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="59182607"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 15:12:09 -0700
X-CSE-ConnectionGUID: pSkPsfgoQUWVp+Zh14u92w==
X-CSE-MsgGUID: phjLkt9sR3+tqxDtK++fNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="163516804"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 15:12:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 15:12:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 15:12:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.68)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 21 Jul 2025 15:12:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YE4B7wQi1DLkAFkogmDku97wlQy2vNmGSMyQ6+eNTc1S3SWKls9sfa8O2kaURr8T61nQYlg7SDzucS62ufQ6zI8dwOIgBnvzwSsklnVGWV3YLxp6HIospCgW7Bk1k0O+CiTtq9UeAfalGtRhpRGCUnCXPnlO/yCe29YFHAA4aNLJBq/o2E26Jx2vAqVpgkdD1Eaer786Ol2z0rb/IkqiPqMxzLvB7D5EPrTxcIEU6SLGDiZP4qDABLk8Ox/9ls3zBv5BJoyk7b++fvwLxm8S4XNiQtyFmZYh1/V14Fot9A3arU3EZSOjKG1VCxZacuAiUxmJmBpPQe9S91TpMSJXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaybOAWRdfGwf7oPRJYDUrhVdo24bPCSdO4Cx35+EEg=;
 b=MpRA2je5mrscwiYeMXDGDHVEReL16Yi60OTLQIEqoyaoF15oSFAfARHzYkGy+dv8yHVEoWiaRi0wrOke9XwoF//q3qoitaRHwhqrRR4SF4Sv+tBByFGxpra/81fN0zVvGXU9ihsMD6cRXwgsXn4xhFo7XW0AkASQbPYUHi2BeQxF/G+CQuTgHFrEFUO1LK/tBSw4OFa9igEjooc8p/a2Ps1kdg7DLeysDxscQt2Fb1iKXcqygP4FAWB4LqCTx7z1PYKUvhaRDhM564lRbxO5K9JscIFmYalU8ofL0cxntDneSaDjDCYGN6oE4cIEewqQFuykwfVWYgNW9MuhYPrPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB9135.namprd11.prod.outlook.com (2603:10b6:208:579::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Mon, 21 Jul
 2025 22:12:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 22:12:05 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 21 Jul 2025 15:12:02 -0700
To: <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Gregory Price
	<gourry@gourry.net>, Li Ming <ming.li@zohomail.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Message-ID: <687ebb328b153_137e6b1004a@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <687ea083ca60e_134cc7100fd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-2-dave.jiang@intel.com>
 <687ea083ca60e_134cc7100fd@dwillia2-xfh.jf.intel.com.notmuch>
Subject: Re: [PATCH v7 01/10] cxl/region: Add decoder check to
 check_commit_order()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d7ed4f-dadb-4d92-f999-08ddc8a3a072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnhaZ0lCYXZZTUNPMW1Hdm5sUmtUQ1RKc1RjbHZYa0t3aFFISkcwbEpySEJR?=
 =?utf-8?B?bmM4T3dWN2xuQndlSmhESlB5ckx1YlE5Sk9MZFBPSDc3enMzZ25SSllJeG9z?=
 =?utf-8?B?UG4vMDgwQ1NvOWszd1lxOUhIYVFYdUpnaWFoL2duVzhvQkljYnYyZG93OURz?=
 =?utf-8?B?a21QMjlzQlBCcFdHVmtuRWtmaE5HK1NKSm5rVmlralh0emVjRFU3VkRST0Ux?=
 =?utf-8?B?c1R5TStOSkJlNU1LREpiS09VWkdTQmNVQ1ZMVDVsSzJxd0g5blk5U2RFb0pa?=
 =?utf-8?B?L1lwQ2lrU1Q4NU0wQm8rMVpVYU1ZQ2lGUWw0eXRLb01MMjBrWWkvUDJheXVp?=
 =?utf-8?B?MWduMTRjSityTmZONzhKVkFHVWl3cjczamRRdmlRNFlDQklFTDBjOGxFRnFP?=
 =?utf-8?B?L09JZXFNUi9DQVRVTitsaWtVMXp4a043bU80cnlVcnVRVjM5OFFxUEhiUEtk?=
 =?utf-8?B?OStYaW9JSURlQjFWUnBab1k5cEc0aENMR0hKZVhhWkJmaFdrVHhHRHdRVzY1?=
 =?utf-8?B?QTkzTjB4eEk4NjdIRkVkU28zTm9Rc3ZMcWxUbWRsSGtONElQRjBlbWNzcjlr?=
 =?utf-8?B?amlHUmJIYUc3d1FEbDJVa3BQQ1JPK0I1WWg0RGlZbERxZWwwUklLVjA3OThj?=
 =?utf-8?B?NjhaZ1BqTFBHaEFaMmE5RkRCY1hjU1R0RSs1bHVXaEEvcG5FNkdnalE3NStq?=
 =?utf-8?B?aXFzM3o3eHFuSTI4cGdvckRNUis1WFhaTmJRS0dIKzNMc042SytvaTBaSVRC?=
 =?utf-8?B?dnRFeURUYjI2cDdkMk1KY1oyNUw3RGZNL21SOC92WmowZVV0UHpxaHlIYUox?=
 =?utf-8?B?ZjlFeVp5N1JMVHFxRG9aMVhSaEk5T1hRc21DcHMyVkE2cnFLVXZGY2NxaFdF?=
 =?utf-8?B?QlRWcjlpVDExbUpMS2FYNnV5ZWs1UVBmOVFRaXJXMDNNMnpjenVUVm83emta?=
 =?utf-8?B?SldsNzRUeTZ2NlNzRGhmVjZrVVkyR2thVEovam1kNnhrVzhRZG5zQncyK0hV?=
 =?utf-8?B?Mlk0ZWxxSzNMV1N0cERxd0dqYm9WZ1p4eEZ0ako1bXErNlFRVGg5QXMyQXVL?=
 =?utf-8?B?RWRzUUpKS2tHKzM5bSt2RGkxdnpzYXRKVDhxZm1IWms2KzREUURnc2IxUS9n?=
 =?utf-8?B?d0pjZDd2b3V2Z0lDeDVsTk1sRHcrQ0pad29Fb0dkUjZJMlk0S1FwN3JZeXpE?=
 =?utf-8?B?T3dNbnk4a0Z5Y1BCNjlCSlU3bDhHRGJKSk54cGhwbFAzODFHOEU3eFF2UzNy?=
 =?utf-8?B?bk85SVZ0MlJwV3RCckJ5Sm42THZCajV5TnVoZnNsWTRLRjhNZTVqcGsxTW95?=
 =?utf-8?B?eENNNHJ3YVhwTVVKemYwTEVLVVp1MGJHZ0xxNkVvKzNPQkRPZVhDVGNNNy9X?=
 =?utf-8?B?TzJvS0t3ZHA4NWc4MERTVUExSG9ybkRXVVBYOU5RWHF2Qmo2NVBDSlUwVm9K?=
 =?utf-8?B?ZjA3UXpMdWdsUmVHU0t4Mm84MVlCUkVVbHduYVlsakZBVXcyYndYL2RYTEUy?=
 =?utf-8?B?bDg2TXJwY05rUjlqZUFZc3BJK0lMWmdSSFliWXlJYmNsV2tJV3BUSE9KVVA0?=
 =?utf-8?B?NEkzNTRpaVZqdStOUGRab3FVSjF1YWJJWW1ManN4Y21lcW0rSzFycEtneExR?=
 =?utf-8?B?cXlaWkFFT0ZocmMzbVFQSXovRlEzZjFGSmk1MnhiMk1EbmkvN0Q5UXRBKzdh?=
 =?utf-8?B?Z2VNQXhVVW9Vd1NuVXBvOXErSHNBREVKdEdBQ2V1VjIwanU4MkJndytaVzl3?=
 =?utf-8?B?V1hrK1pSelkzVHNGWnE5S0xLUVRLYTVuZm1HdXNwYW4vUnRWUDJCaTVqa2Yx?=
 =?utf-8?B?UG1lancvVUpnRGxSZjF1RHY4Q0greG1ES0t3Q2NQTGIzTmNQWGlSYUhyYi9n?=
 =?utf-8?B?TytNL25oVm5ORWdHYlJvUndzYmZnOUVUTWRyT3NkajV0elh1M2cyTllTb2V5?=
 =?utf-8?Q?/tyO6mBv/AA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3NzOGVHam1VdGZBNGQraFdyTGZJcGo3VlZsY3BZTXh6WVZBTEpDQmRWVU10?=
 =?utf-8?B?MWJNQWNOS1pVR3JQVlExYU55OHQ5UnBNUVFuS0ZLN2dSZ2hZdjB0MVZIOWI5?=
 =?utf-8?B?SUhlcjRKeFNhUjJsSENYcU45bDF0ekRXd3lIR1kwTGVJS3dVYjhqcmY0TmFZ?=
 =?utf-8?B?N0RyNXE0dFlTUVhLc2txL25zYkxvWU8yZ3h2elQwek1aOExnTm9TSFhaSDg0?=
 =?utf-8?B?OWp0VVNISW11WWlaTEZONVB6ZHVxQXp0REFrNU0xeWg4cXZhb2xxaG00a0xi?=
 =?utf-8?B?ZWNmWlR0M1lBdjNYQmJDelRQNmt3MUZQUGxTVTV6YjMrWk0wRG5haGFnZjMw?=
 =?utf-8?B?NVQxWVpSSVR3WXUyZ3hoQWJ6dm5RY1RLWTdDZURoR3BwNDQzOC9oZGkzeGJU?=
 =?utf-8?B?ZGlLc25wN3dCM01GMVBsK0ZnZFJLcU9TWFJxeEk4QVY4S2pqSStuQ2lwUUFm?=
 =?utf-8?B?M3lHSE1aODVZWUk4Vk5VYjl0MUFiSzM0c0tibEpQU2tXYkxiVjBCRnhwNERR?=
 =?utf-8?B?aVZNOWVIeEZ4YlY1NGRPaFhXR0FDeUpPVHkwNTQ1TUY4eVBMeTcxNkJSUDFk?=
 =?utf-8?B?bU4xQ1llN3FjbkxZVHR0SVhzVzRSM0c0ak1YbkhIa2cyV1Q1c3Z5cDJmb3Np?=
 =?utf-8?B?TkpTeUFDb1U2ODMzbWIySXNWa1YzZlpmQXAwd1VoWnUxN0VNdVJpaENQUmdO?=
 =?utf-8?B?VEpsNC9HNkY2UkxMNDRnZGxwS01pWHorN1lNQklxaXZzdVRkcGZUb2FoaXYr?=
 =?utf-8?B?Mjd4cUVvVWVxYVJPVlZEMXdkbGZvSjdZRHNua2crTFA0OFdCSGVLYlhwNThM?=
 =?utf-8?B?bDVKdTZoKzNyZUtPWDA5VTJMaURHb2RuUlMxVlY1Yy9mR2dNSkNtVmdxc1VP?=
 =?utf-8?B?U1VjMFp4NnZPZWVyNS84ZUdKMnp0UmZMSXpRMEFqczJ1VlI2d05NT0pGTUtO?=
 =?utf-8?B?SUVSRHBJVG9qTHZPa2lQVDZjZmlCSWdmWUpSWlhPY3FLZ3pzZmg4MUlqZzNi?=
 =?utf-8?B?L2xUbXg5SWtDVW9GZVlBWGJha0hpRkZwZXRCNXB6K3NUTWhXeGJzWklxc3NV?=
 =?utf-8?B?aUIzWFhpcTFnOWtaNkRGNHArYnQ1eHBrOVZmQ3F2WUpRR2Y3bkNWb1VnT2J4?=
 =?utf-8?B?VmdmSFFqNjhHeTVNT0Y0eHNCTUN5S1VvMzh4N0hoNnEwVVN0ZWZpbkZFUXIr?=
 =?utf-8?B?UlN2azNPTjFMaUtMQ2VPVDRqSUQxdG4zaWpScVg2S1R0c3FDRFE4NDZEQkhJ?=
 =?utf-8?B?VFRXeUFZMUZ1NWpKU2taNVJEY1ZKMGxKUmxnT1lWd1dyeDFudm54NDhDbWtj?=
 =?utf-8?B?QzJMZzF5WGphSnd6SmQ5UEVCaU9iN1RYa0pzUGxMSG11bUFkd1JwVFg5aEhJ?=
 =?utf-8?B?S2tRR3BxNUhiQk52WnFMTVZHaXAyb0xGNlBNQ3dDWEE1QmdMdHR3UnF2STJa?=
 =?utf-8?B?ai9QZVQxWmJDWjUyK09CUytkWk5iMi9kai9RTFpHQXhZWU1sV3JBQ3NRWXlM?=
 =?utf-8?B?NFJoNE1vTUN1OTdOcDNtRVJJTElUU25GQ1NTV2JhNDh1NmUvU3B5VWhBeXBo?=
 =?utf-8?B?eGkzK214U2ZEeUxobFowVzVSU0tYbnE0Zlh4dCtESldSMkpEVkZTaWhURmVI?=
 =?utf-8?B?a3FXQ2M3cVBHSlZ1RVBLQzdQSnpDcVRMdEhONC8wWG53WjBVT29SeXFPOUFN?=
 =?utf-8?B?cUxCTHdQWm5pVkp5VE90R2ZYQzYvanJTMFpMS0pXZ25QcWlheHlUcENpa1dO?=
 =?utf-8?B?V3hWM2N2eWplbGhRTmlHQmxIK2JNaytCbWJDV0x3UXVuMUc2aWVyc3YybmJT?=
 =?utf-8?B?MFVwWDVEZmVvZ3EwdHhtMytiV1JLUS9LSU50aDJpQ20xSExxSTRSR1pXRFlT?=
 =?utf-8?B?V09Cc3NYeEVxZjFZTVlJMGRsZkZ6NWo5SERCYnVCY3JJeS9uY2lOb1FBd08v?=
 =?utf-8?B?bXRlMmJzeXNlcmlISGRRbXRnaVpUNFo2L0tmT3g3Yjl0VHRkSDRTWlJtQXVr?=
 =?utf-8?B?WjFCaUhXdFNVeEYxeFArVmMwNkx5ejk4TnI1Qmh1MlRvU1RtVUlSSXh0NE9w?=
 =?utf-8?B?aUQ0cjBOaFVab1dObHc1Q3d4R0RNNHVsVVBJUVUxYnFOdkNheFpvdkNudlJq?=
 =?utf-8?B?VTF5bmlxc0xCTVJ6UGJEWjhkQjI5MEVWb01ySUhLeVluNGxFSVJUS3lHelU3?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d7ed4f-dadb-4d92-f999-08ddc8a3a072
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 22:12:05.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFJrFcDpZ7ThX6vI+GAQLS9BIwxa6J/UJjHodL8bRPo1qEuxh21xQJRCuPatPKh3wOU6b4P6NklUb0feIJ5V1RldqdPit5kyx9QIVQcvBd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9135
X-OriginatorOrg: intel.com

dan.j.williams@ wrote:
> Dave Jiang wrote:
> > check_commit_order() attempts to convert a device to a decoder without
> > making sure the device is a decoder. So far this has been working due
> > to pure luck
> 
> s/pure luck/cxl_port_attach_region() only handling switch port decoder
> assignment/
> 
> >. Issue discovered while doing deferred dport probing when
> > child ports are now in the midst of decoders due to ordering change
> 
> s/midst/mix/?
> 
> So I went looking to see if this change actually makes a difference in
> the end, or if this was just the result of debugging an interim state of
> the code that ended up passing non-switch decoders through this path.
> 
> The disinction matters for understanding code-flow and history here.
> Like something is wrong if this expectation is violated in some future
> refactoring and may even be worth putting a dev_WARN_ONCE() in this
> path.
> 
> In fact I put a dev_WARN_ONCE in this path with all the patches applied
> and it never triggers with a cxl test suite run, so I think it is safe
> to do something like the below.
> 
> ...but before going there, can you confirm the expectation that the
> safety is not strictly needed?

Ok, so I finally remembered the previous discussion here and switch
ports have both endpoint-port child devices and decoder child devices.

However, endpoint-ports are always added *after* decoders. That is
enforced by the fact that decoders are added in cxl_switch_port_probe()
and endpoint-ports serialize against that before adding new ports.

The device_for_each_child_reverse_from() staring from a decoder makes
sure to only see decoder children. So check_commit_order() seeing
endpoint ports is a bug not something that should be silently allowed.
