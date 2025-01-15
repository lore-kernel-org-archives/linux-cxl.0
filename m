Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C33757FC
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950623; cv=fail; b=eSbK3KnGg+ZB5AYf1UJd/FfTPQIpt7FWYPOYiObtIwbTf+5jkkblLoIjawPBXV6Kfjk3J6VGjlJLv9jvZUZkwDpSWDBpch1NIVd+UpSRt7yXslqPR9P0Ip6DVdOvsXrjhEe+tSyekoPpfzI2yz+at+h5t/S8DGhbFK/jArytv5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950623; c=relaxed/simple;
	bh=QbZjfuKTOerYQsNDVEmejg/U/RG3f/eLGNf1PsZROD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eyePKUA5kzqydAv+pWSW9iLfX9ZGV7jd8ARqW7yGUwyfGm7AMW1V2JmxFqwdzPlupFurgxVQAUAjYYTefkTj0zoMAuHKBFsVgDPRkPRaAnnvBQnAnUuZN2ujLreEflk9SV38dB9uWHklVyYuh46oEvexbdEPatlE2o3+g5X2nWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GAmMKAtu; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAmMKAtu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736950622; x=1768486622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QbZjfuKTOerYQsNDVEmejg/U/RG3f/eLGNf1PsZROD0=;
  b=GAmMKAtuOJZ767MpJS8HcNjD/ZbyZVmqb3EuGT+BQQqj+HViOnMDICtH
   rlbg6geZqDkkdPqYYEtBBMACPwlQu121Bx0K0Iqk/oJrPUJrQ0xRJ3Kp6
   8GR/jT4Fq0hxl33+gHHU5NJZxt/tApznTsSL5f28TCZEanu3gY9GTsUJe
   ow3F4eOJoeVevdDmzAlUX6RnwbOm1q7u9ploFe7ThElY1wf7N+gygUCQ/
   QgMDcQnVP+h0vXf2PQha7JysoGVPuGkggW7lhd0nY0qPgos7r6Nq+3Gmn
   jBCHtVbVeF854oND9NiZg3dmYFnjUM9sxyD6KQJSdYxIud9J7fzWNxn5y
   Q==;
X-CSE-ConnectionGUID: siXxqy0DTSu0c4i8DKm8EQ==
X-CSE-MsgGUID: bwtjjekETumjq85xK7Ovmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="41050641"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="41050641"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 06:17:01 -0800
X-CSE-ConnectionGUID: I1mJ0mn4Q4O+mk+6ZBx/sg==
X-CSE-MsgGUID: r0FPY8nZRqaec4OvI/u0Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="105106467"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 06:17:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 06:17:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 06:17:00 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 06:16:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gg14tO429Wy4VBJkz/PcWZ2f0trSc3vDSzb/cWESbykjv8XMkLpPOZ8VntRwFeDJfCldbEolhtg01eRxKY7XZ8xE2UurpJtgudpwtNw7xdXHg8ToNkQglVT9Ny9CzmLsjX+b6nG8csO2Tc8wjPfU5GgazNi9FswJhTyrRtME5WzYjuGBxaJ50GbcVMQncn3iQPsmhCAcba38GA1XWSxo0tFxsIcVK366fIZiTSyRMG9SzNXlrXwpU/mqpyWYfT+rNcvTI8qRxXC3EAnAJqCM+jPJrmAzTKZjjWTZpJCXRNPJDntkoiPPZll3NeS99l+H0/pX9jLBu+m7WTtYKfOzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iu5CoEPZnCoQ9+SojY0o9DPCFBJTwAkMb+FBq9LUqyk=;
 b=TIWaEMEOOkrSUc62CCXHe8oAMBlrUppJc7gGHY1zXyWa2AUNb5u003RHECdEzQceVtSB0ruliYjO9ZvcRGOmw8ocefKO8xi0F61UsTO7UrsJ2aQk2+steum7XBkGqCJ3fFDfHACE/gYcxeZMbVQVSRIE4GlDLMogwM7cJImWESoyl4CwrwC921PIqLMy5uq72vPiUT0xo68gqUzbDWJbjaFJLd3YRsqdhPdc/8OUWwJJ8wYJabPQ6PhMSDTvK380hmzaez/x/AjPPUhuyLRfuP0QpnZbDGSj9HqELwxz4vw7fZHox6LxBD7+GtxHYC13itTaF2a9cCM9yqIVlmT7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB7461.namprd11.prod.outlook.com (2603:10b6:806:319::17)
 by MN2PR11MB4582.namprd11.prod.outlook.com (2603:10b6:208:265::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 14:16:41 +0000
Received: from SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::4ec0:56bc:1ceb:7c06]) by SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::4ec0:56bc:1ceb:7c06%3]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 14:16:41 +0000
From: "Ye, Huaisheng" <huaisheng.ye@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, lkp <lkp@intel.com>
CC: "Williams, Dan J" <dan.j.williams@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "ming.li@zohomail.com" <ming.li@zohomail.com>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, "Jia, Pei P"
	<pei.p.jia@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v4 1/1] cxl/core/regs: Refactor out functions to count
 regblocks of given type
Thread-Topic: [PATCH v4 1/1] cxl/core/regs: Refactor out functions to count
 regblocks of given type
Thread-Index: AQHbZoXIyKgYJRxE0Ei1SB2ksk5agrMWXdaAgAF5j4CAAAeOIA==
Date: Wed, 15 Jan 2025 14:16:40 +0000
Message-ID: <SA3PR11MB7461B51E81106B648060C70C9F192@SA3PR11MB7461.namprd11.prod.outlook.com>
References: <20250114131041.17512-2-huaisheng.ye@intel.com>
	<202501142243.PmkW84KY-lkp@intel.com> <20250115133437.00003240@huawei.com>
In-Reply-To: <20250115133437.00003240@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB7461:EE_|MN2PR11MB4582:EE_
x-ms-office365-filtering-correlation-id: 022bc6e9-3ad5-42b5-2a82-08dd356f3b5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3MvXOoNXGAtB3ozy51Lckwvu+maGyMMxnZPgYUrE3FmYB99T1WY9ntlLp3nO?=
 =?us-ascii?Q?8C0RgrUuNX4gItVA3qn7xMi/NGUF72EY/Qb7inQrRLHvYRBZaM3CC2hlFku9?=
 =?us-ascii?Q?D3KON0izkbxM3mMeEkvM1DJ+072c53KXUsNI72CKKy3d/D4uPli0suBD4TCQ?=
 =?us-ascii?Q?1g/ImmQPGgpsa0olJPatZhSjAwCkk7GocfYyFywWOxP47023T3L8sEQD19O8?=
 =?us-ascii?Q?f9DiS3mcTjNMlsYwQpQ7PyX0IdJTHHXw53QsU/2F/yIqUCwRKx+W9Sk7lRfE?=
 =?us-ascii?Q?FyjIM64NaDYWLp8Bg6dp9hisG1sVSdZaHSaUQfNHWMooju3nk62xJs0Umha1?=
 =?us-ascii?Q?UWcbu10PkdNlAr+xBkoJxX7oJxkME3DnvmtQ3BlwT1MShgQbtpm2TMzJFY0l?=
 =?us-ascii?Q?rwUNYNeTtu5jDkImOkJqA59daG8r/Eb+f51g7/xJza8TEUhdyI4X4iwWQFJ/?=
 =?us-ascii?Q?f2zXJ5/gESEWNbRHahihqQV2xTT/s1n1nzzAG7uflzw5xf85X9fRnXv2Hozo?=
 =?us-ascii?Q?boJcAIW8UHq4QtWEWyv4o8hOt88APo+PkjplCwXrb9zq052TQ2njItP9HfXD?=
 =?us-ascii?Q?VGp4Xku4X7T1NsZK/x15q220z3A2+L04bIs+X4G8NuV9kfLuOOmVwJID5V6F?=
 =?us-ascii?Q?pAzdROpVn+Wjrfe/hrIdZPAL4ywnXzx+giy+fGoCUeqB1aDXJTTH6XTeb1kL?=
 =?us-ascii?Q?/J03ezyjoY2bCV1XhvY0Tl8gE5hKdrjwV5GhH7XhsYTEqtPEbXTgjhcWr1Pu?=
 =?us-ascii?Q?iOO7DmpTiG1hYvW1EbhvaOnvGLwuzVTvxuRWY8wckPZrs5gHASQUjRLVTZWh?=
 =?us-ascii?Q?hE5VK6JuBn8dD2Oc5+VqSRcH5/yI8VoZj1mwpIeFTHRbF/VnHPlfWTXmWKAS?=
 =?us-ascii?Q?JSRBTJOBhXuYu5T65bzQzIE6cYbkhd/4G0Ego5BUCFLIeuKInuebXtQONzuM?=
 =?us-ascii?Q?bm4qeHXrB7cgZPZZsi47V9Or9KXwUQlfTFDDJeq9fgq39NQPEj12iXwZ5p0Q?=
 =?us-ascii?Q?n+WIdGB+Nal2iSfa7kbz7H8MBKg+UwzsdgxfJoJ9skicXSeSaIrsrPm17YoD?=
 =?us-ascii?Q?/324QAydN77+DVjkluPpfZScDzSSSjCVbUxm/FbImRPYMDD/m6FK1pORclrZ?=
 =?us-ascii?Q?Sph1hw2vwqrhUIbckvfExF9DKbS9vR1bWb4mGa92nMlG4G+tyF7hPdPGER4D?=
 =?us-ascii?Q?BIXXizb2HQHwfExetO+Spi+ccTsqcPusKx49mogMfZOAo3LAe3szZ550Y+z3?=
 =?us-ascii?Q?X/DpUKcZQYdwLLL2HFUZBMjG3WJWFdaLthktqk0gF/WASM8keUduIWPpIXTx?=
 =?us-ascii?Q?BI31AxmoXWBqBnqHd63A8TxCt1UsLbMf8e1sktNBSjQrXajRDWtE3+k/5UB9?=
 =?us-ascii?Q?VPzZbbWaOnAJ3pNbVkurbZiOv4VcYUKnmWH640PmL1+V2Xb5SJ32pn2dzu+B?=
 =?us-ascii?Q?aqvO6+kJr27r35uCShJZFZgI47tyPNEB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7461.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xfSV8D08ZxtsOuMo9HYdHyNABUfx+75biOalGfjGrTHUJlhYj/oXDdSO6RJU?=
 =?us-ascii?Q?FauIcKvIVfGzerE/gQLG1l9TuP4IRlj2ow0K2fDjlNYTUky+O8aNpgOpfWNH?=
 =?us-ascii?Q?a/X8uPpeci7R91xSaCk1YDbCmqE+50cGuHCJTQDlUAEBh7WMa7JVHYH4bqMX?=
 =?us-ascii?Q?LvFb3vbjfBD5zmVA5XksDS8+oVUCn31o+AYWgTg1fQnXpp4cqPl2OoMFbg1A?=
 =?us-ascii?Q?o9L0PwxM/3rE06DtQNBf/E69mPHB6uKRr0PXHYAMQCnno6pcb/lMIQP7OPLZ?=
 =?us-ascii?Q?y1GwpNbyi6id8nUn2nEmZgOzNA/9v3nnHYpOvglpb9L5bw6Lx5GM4PwP3R8S?=
 =?us-ascii?Q?RljTzdduqLE0OXlijmAAscH+WjXgHgQ0jTzLENQ0+bWssDrDP+6SZZkUe+7p?=
 =?us-ascii?Q?ZkURHGuSSoUspIlQrSBnPYOYcJntAZ/X8dxT37BqczPJbSpgIW4lj/6rF4iS?=
 =?us-ascii?Q?hHv6uReFEIO9Ry52cVCh8Fi3Z3+hAXfX3UvI4/nflvYBQbdsjBjMJQsfFYly?=
 =?us-ascii?Q?PkkkaGoxgKOl9NzkwBAaplmSAnr0O97B2p3vFLnJkhD/udFIBH6EEaNpI70p?=
 =?us-ascii?Q?PrbL2PO2gB6JuzOZmknqnSvGeecx500w6MKOmKecASLJAN1gPZzaV5ycFTxi?=
 =?us-ascii?Q?ODSQHHPeBGy2ZKiqOnry78rjrgPcAkwK58K8RUxPowzFHob9FwVDGWdJdzkN?=
 =?us-ascii?Q?LNO0Z9j6JnIjDE6/PkUVlmgTy9QNDrxXoQWCdUEQhoCKUXZS2JWof7eKCJMj?=
 =?us-ascii?Q?Qn/MTnjwjaDvk/NLt0jz11UMRpj9YE8Csb18xUfOdg3FYxmif9Dim8pPp6KF?=
 =?us-ascii?Q?s+JHp8DpYIrX+E7kNDrqETpUIFtV2450Ow+YRy1fiVtKaq6UozJ2vdfIrG+B?=
 =?us-ascii?Q?YSU/uTR/xl1V3MTKyuz7sFVXJ4tpxasAtk7e1pL0ja3/oU4BvEgh+6Fvj+NI?=
 =?us-ascii?Q?p5FffN5RVYCocjZq9fo02UqMLHNqhjrliYisGIqMZjeqppQtvbOKcAKcjdO5?=
 =?us-ascii?Q?sozYh220h3clvUKWcWEdIpdKFweBNNzp9vUDxVY8vbp2pT52dcHyoz3ZWS6z?=
 =?us-ascii?Q?v7HPbMSlBJ5R+sl5tS2sbeu+fgInPcES7iT6efYb2HWRK34Cjgn45kyS/yqo?=
 =?us-ascii?Q?EZ89kw7iT4TS5IRh8aWKQRIwN2oMbYkRg9rbpNtFhrDy4U6KcPK91DHG983/?=
 =?us-ascii?Q?1s0esjPqb4iXJn7l4PZuryRh+F6wIsLFi7Jf26avmKm92tn4uGcFzO2ZhmOc?=
 =?us-ascii?Q?Hy9j9Ly67rmMvKNGTUIQBm5RARC2iObzCd54kGsqatC6v9jJzWX/4b9vjzn6?=
 =?us-ascii?Q?6QWtVCoshtOhlI/DFohEx3alFtZWxuSt6c1BI5RGnI/epwnt7p9iefnvZ1xG?=
 =?us-ascii?Q?dp3bgMapJUNWlGyHnEwFySe4CEkiYiJ3QO+HDzuo7O/LMo5pM2vxfbuxxTGa?=
 =?us-ascii?Q?tojxhEhUozVnZpTShqCPvJj1iTNvqhW7UQwjOdibdQL/DBc3Fxkh18YVAyk5?=
 =?us-ascii?Q?CHEQTS3XJBinHny4TaIcfnSOeKM818DonzDKGODyY0+IHMMIJ75WuIUT9GbO?=
 =?us-ascii?Q?RolwscuMH3dmdQO4dalFQk2XnBd0pWkpfAkNXlI8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7461.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022bc6e9-3ad5-42b5-2a82-08dd356f3b5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 14:16:40.9348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aSJMTPOpJig9uAAz+L5O5bf5SgVSWTjmOtF8iFK3dJMpsxMgc51+yXrey1P7Ai+eipNV6HHnE5Bloe0bf03zZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4582
X-OriginatorOrg: intel.com

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Sent: Wednesday, January 15, 2025 9:35 PM
=20
[snip]

> >
> > All warnings (new ones prefixed by >>):
> >
> > >> drivers/cxl/core/regs.c:303: warning: Function parameter or struct
> member 'pdev' not described in '__cxl_find_regblock_instance'
> > >> drivers/cxl/core/regs.c:303: warning: Function parameter or struct
> member 'type' not described in '__cxl_find_regblock_instance'
> > >> drivers/cxl/core/regs.c:303: warning: Function parameter or struct
> member 'map' not described in '__cxl_find_regblock_instance'
> > >> drivers/cxl/core/regs.c:303: warning: Function parameter or struct
> member 'index' not described in '__cxl_find_regblock_instance'
> >
> As you've probably gathered from this, kernel-doc needs to be complete.
> I'd just drop the extra *. This isn't stuff we need outside of someone
> reading the actual code.
>=20
> /*
>  * __cxl_find_....
>=20

oh, whoops, my mistake. Thank you for your patience and correction.
I should run scripts/kernel-doc firstly before 'git send-email'.

Best Regards,
Huaisheng Ye

