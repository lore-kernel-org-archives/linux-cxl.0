Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB491267AF2
	for <linux-cxl@vger.kernel.org>; Sat, 18 Oct 2025 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760755552; cv=fail; b=TYi5Y+SUxywur/hajAaZT1BEWbTU0zb9PwcZLXQF4mv/TlZPRZkwsEZT3IFx3HTclXpFJWivri1m3XCHHH3/xfm59XL374lynkNWylOLjSvlv0kAraXzWp/1rxUE0o9/JTryRSdsQl0GmCR85UywQVTCCMmkLHeTUXczPwc3zzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760755552; c=relaxed/simple;
	bh=xNE+THgTosRev+IZhEN01O7tMYiB9wQivtra0QR2Zv0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Ql9HtOIDRflVC/yHQ11uPMpCwtKzrQ3/WLeByWbtQ/B3VTgYV1b8NQUnkqEK2mKU1AFOnVnr4Wb6LjZn6nQCHEplzNxYCqbrw3GvoRdXM+pbpjL4gEQPB/EL5j7Z9r5+Scara/TE9Y/8RAFkhJsbmgP+TF7ZbrW4odfnoWe3eh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oe3eKml3; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oe3eKml3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760755551; x=1792291551;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=xNE+THgTosRev+IZhEN01O7tMYiB9wQivtra0QR2Zv0=;
  b=Oe3eKml3gbne2+Xn5G2+IbqRRWoZvtIXbblrN24S3JsIdIIv3ZlpH5wV
   710efg2+lrnOL3zAzbC9Ly7xgetiDMlMWIlK33VXlxxFZLcMe5pIxx5bF
   2GgVpMYFMg6keUsNDU6IfYd5WSPcLDNwucQlh3rSD3jRlvpco77JVujYu
   vJ1xiU4gk65wQCzd6sMut176pR159Zj5qCUtyzPJMLdU/SAOzmEZ9a//+
   PHMAFfLzv247v+sc5/RXqrbGqx89WJhMYHke385FLra/30LGVbVz+i//0
   T5Qc3ntkUgZhmRkMqK02m0k1grZHqcFyatdVOjvFxs/qVjj/wBPFLn57C
   g==;
X-CSE-ConnectionGUID: stjZquLkTRqxPQHJKZCOeA==
X-CSE-MsgGUID: fioCa7PYT/W6QuzrG8apcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="63060323"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="63060323"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 19:45:50 -0700
X-CSE-ConnectionGUID: Klcg/fTvT3q5fEMNHrwnGQ==
X-CSE-MsgGUID: nfUigTErRaC/B6evR0d78Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="187287840"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 19:45:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 12:10:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 12:10:48 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.22)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 12:10:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kW/x5fQRTEGBPLpYKxOYAw7X1A3ZthSUfucm9CLhTVG+I4MnhLSQXkL6WEeyUOWobpHAmtoxE3LFil9EKdOrQcQkh3iu+3x7RsRaEKDb1Kzw++gqpxUrU+FpJjPLjrrRYqFgCBRRpluIIYQiQef3yaPx3rgFhfkUhh5a9MMuAbWfOXgk4KSZR5PCFi2q0TFizlA2Nwu0FWHYtKZxPrS7RkVI4e6AOLpNhn+wP1J6XfoPBYJp1nOqb31TObn6AwpqtdnO94KYFmnZRIOn1iS8ys7v/dh3fwOm26ulpe0AjyUq21f67g5VQffL7qImadYZatnljIk/HzKoC37uT6zkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2gWBeltQ0lyd+C01jAp4kgS7QHHViA018RkL8PWByM=;
 b=J1rwj8w3ZTKTGrGm4/kjYLR3Rc3w3FHHEUpMXXdWUIk6X+8bOz3R4igkPmzG/YJGibhAhiGgnLo+Sqk1rH2Phxgb5lsv3kuNGuTKFVbDjY4zhEh5KNP4V9I5bHahq7wbIrPRdycuX8+jScjt21ROq/tCFqelD2o8YhD7VV3i+5FTym+iLQvT0SyV35jfwBlK2DDyQBMuPNx9d6+TGN360iMPDGXi92sgILZXczhXi6X9j4NPHzSQwXZWClUz1//UDmYVRcSV5QGQy/uzJUywA3wvXaGP1N063yX6acbkojGVd5GzxODHYn5fa9MDjJ+aLrTv4iufNILrfrDoFaKUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 19:10:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 19:10:40 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 17 Oct 2025 12:10:39 -0700
To: "Huang, Ying" <ying.huang@linux.alibaba.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>, <hch@infradead.org>,
	<a.manzanares@samsung.com>, <fan.ni@samsung.com>
CC: <linux-cxl@vger.kernel.org>
Message-ID: <68f294af24168_2a201001c@dwillia2-mobl4.notmuch>
In-Reply-To: <87zf9qf46z.fsf@DESKTOP-5N7EMDA>
References: <87zf9qf46z.fsf@DESKTOP-5N7EMDA>
Subject: Re: Deep flush support for CXL pmem?
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2b5145-4de1-4689-eabb-08de0db0dc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzBQR2ZBWDNKRWZzaHgxVmorL2FGY0k0QnhtSHdiaXJvMHV0b01ldW5uL3kw?=
 =?utf-8?B?NnZtY2I5aHJRRC9CdWdrUjQwSUZVZDJ2Um9MNnZKUTJKS0VqaUpFYU5KNnJJ?=
 =?utf-8?B?cVVOOVVqc3lDZTI2NmJ6OGw3T0NVVWlabHZNc2dQbjVkdTloUVllNjNjVTdS?=
 =?utf-8?B?L0xLZDczeGZOVzVzSklhNjZ5L1R4ZDAybUtJb01wQTNuN2pGRnJlYjRBajlT?=
 =?utf-8?B?VDZXMHdzb05pellLR0JJaDBLVjNGUVQ2Mkl4QXMyQkhuNG1xNExRWUU3ZkNL?=
 =?utf-8?B?YU4rT3Q2dFpXd2dRdStkeXRvWnpHSmZTVS9LT0x4NVdENWlwalp5RGd3a1FD?=
 =?utf-8?B?MFBZYkJSbmpuZDlyTm9FRVc2MlVQb3BmZ0R2ZDg3SUFJMDIyQkQzZHZzR0tK?=
 =?utf-8?B?ZU5VcVAyZ1RncXg1UWRKUk8zSjNxZlczUkZSVzV4MEh4VDEwdFlhYjBOMUhZ?=
 =?utf-8?B?cTJkaTVmcGZrYkl3S3pRSEo5eE1uUVBURlJBejNNZjY5MG5tTkVzZ0xQSzlK?=
 =?utf-8?B?QTJQUnNubnpSTXJ0dm8rUk0wK1lYWkozUWFmcnRrVm0vS0Q3Q2E4dHdUREp3?=
 =?utf-8?B?a3ZNaDVxWEt0ZVVwWUt1T294L2RCQmNFUU51WW40OHBFUGVibWJYdGxob2tG?=
 =?utf-8?B?MDFyRkFORWZQSzUrZzVJWUVVOEk1Yms2TkllNS9pR0VrYVlUMGhmZ1ZUY2hD?=
 =?utf-8?B?ZU9YUGRBNzJhS0lTbnd5QUhDdU80SGVEYmxKNy9xc25jVlBhTk94czlCV3Fq?=
 =?utf-8?B?UGZYZTdBTzFRZnZKcERkOU5wV2JXMEtuT1pRZ01hT0FWa3JtVjFwZTJQOHA1?=
 =?utf-8?B?djNFU091VHlMcjRZeHU4aHkvbnhNaTJPdVdHc1lZbmNNNFBaTG5ManhMdDF2?=
 =?utf-8?B?TDlpTCs0bUFIYkM0QVUxaE5IUEhxNVNycm9iQndhbE9PUzlhbVV2MVZUWmR2?=
 =?utf-8?B?bVd2cStPVko5cUlNMmpIc25uSVV6U3hLa2VBRGdmYUFyem9uZ0VJN0tIdUFB?=
 =?utf-8?B?ZHRYSk81UVlsRmRUTjBGamxWNzUrMllsbEYwVFUzM1pqN2FJZ2U2WWhSNkJF?=
 =?utf-8?B?bHNTQm13b21EdENCVVZnUW5KTXVyNUxJSmtJWkxEUGtYSVNFcElKbENtelRO?=
 =?utf-8?B?MG8wV1JxL0luUnFlbjcvR2NhbUVhVmdUUUdWbWs0Z1VnRFZ1VXBIUitvczZj?=
 =?utf-8?B?ZU1IZXliYVI0QTNYZlg5NllBVnQ4Ni9uNDk4dmFNZlF2TUhXREFja2VTdjRH?=
 =?utf-8?B?WGY5VHAyTExmdGorMlQrWG9NL1Exb2Jpams5ZXVzWTRuR3kvQ0xOSmFiazdQ?=
 =?utf-8?B?Wk5NNm5pWjgzaHJjVXVtYTFqVXZReWd5d1lSUUZab0haL2Fobi9vNE02dVhn?=
 =?utf-8?B?aEwybmlOamh3Nm5uS0ZDZitlWnhGQXJOaDVNckF2WGtHZ2J2dlFEQkJNTmFE?=
 =?utf-8?B?eW9xUWFPb3QyK3EzS1VodVZhdE5oYVZuTGk5RzF5bC9BUDRETWZDUmprT3o5?=
 =?utf-8?B?Wjl3ZC9JRjRNQllRUWpJcER6bDJZODNHeG9pOHpFMXB4a092dU1ma0trYjdX?=
 =?utf-8?B?WFRmeUpMZXppRWkza0h2cTllTnB3T1ExeTJTU2N6bWcyTWYrMHhkTHVXSUlP?=
 =?utf-8?B?UGxwTTVCNmdhVjlXOEEwOWpodTA5RXR3Q1B2WmZ3VjVMcllBSjdMeGMyYUJi?=
 =?utf-8?B?TXNMS29Ebm1INVNMY3lYbjlGb0NvYzZTajU1czdBM05nY0xXSUt4dGFTUDVt?=
 =?utf-8?B?RzFaR3NDZEtGTTRJRThPTDVCQ3kyTElXUFZvTDlCZEpjMWdiQ1BwTnAzYU5K?=
 =?utf-8?B?aDZjZ2pacnVqUXpxRmhxTkNRVmdsY3g3c3IwMnFGQVhtbUpMUStKcm05Z1g2?=
 =?utf-8?B?dFZQMm1VTkFqUXI1eEJiRXJPTXBoNGhNYlhYUjhwQ1BLSGhlQmNGSkRncXNi?=
 =?utf-8?B?cXpKdUNQWkVIOVVwaTFxVjB1M3Z6b1cyVmlTTXNBYzlwWjR6a1pCWmZ6a1VJ?=
 =?utf-8?B?M3dqRjYxNkV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk4raC9hdHA0VmNXaUJRZjV0NUR1MkFtQW4vdGxGb2N5MmxtTWYxWk9sWS9s?=
 =?utf-8?B?VHIwQlBoRnBpVzhIQlF6WVJVOVQ1U0wxTWYwcitEQVlXMmM2NUduMWIzYnJt?=
 =?utf-8?B?RjMxQ0d4dGluelJuZXpCeXl0WjZyWVBhaEd2em5WVjc3RnVOMU1iU0hmUXZU?=
 =?utf-8?B?elhDcWxaY0wwWldycThlUzU1dmpDNU40a3M3SDRqNEdJc2w4Z3diTDdIU3U2?=
 =?utf-8?B?NWpkYXVRVXlRY3hPdnh3SlJVamhrRTZWVyt1NUM5Z24yZWFLcGlNbXdJWGRa?=
 =?utf-8?B?Rm5TTnRLN2QxZkh4Ykh2YVhkb0ozekMrTGEvOWR1RjN2WUZCa1JqRkROQnVs?=
 =?utf-8?B?bjgzSmVFL1hxay9xeDM4c1FnazAvQjdhWXpJSFROZjA5b1MweXlibkRYVzZh?=
 =?utf-8?B?eWJLaHpaekU4Vzg1T1ZvU21jZy8xT3Frd3BMSmNyVjBwMGN6bW5DNnY0VGNL?=
 =?utf-8?B?Q0ExaENsY3pJY0ZmRkZsVVpNeDdGaW5SM2RYc1dueHdpMjNKaUluWnd2ZTVF?=
 =?utf-8?B?ZjFoUmFzTmtDNCtEV1RZQ0lQM3p5WnFhZFc5MlNtdnJKM202U045U09XN2FW?=
 =?utf-8?B?SFRndHgvMkpST3VqNzBYaHI0NXpKVFhDaVJIYStacW9YbS9YV0xtR2RIV0xl?=
 =?utf-8?B?WDdBcERpam0zbUZFTDhYTDF1eVF1VXNDcWtWNitlUy8yWEV1aVVYNDFDNnll?=
 =?utf-8?B?SEg3TkgySmdPZFdGZkd3SmFMaUxhVmRBYkVWWlZmMWYxdmJrNktXMk5iYW83?=
 =?utf-8?B?QmszSFNQQ2FZZXJpQklhZ0h3TDhpMHhERmlBM3d0amZPRkRGYTRtQTRINklE?=
 =?utf-8?B?VDZmQnNVRE1yY1FOS2Z2NXhJRHIzMzlOQWRYcUpsVW5Lam45cE9DcmtQK1la?=
 =?utf-8?B?bk9XamJ1L2thMHFsdWtUVmVsOWUzM1BGOG5XTE80VElvV24xUnVBb2tSREdQ?=
 =?utf-8?B?cG16WjhRNGNJd2JBeEJDMklkOWhQMnA1Vy9FdWM3Zk9sN2wrRzgrWko2NHoy?=
 =?utf-8?B?RnBGUE4yb0pjbjF5bXV2d1NKVXFibUlZNGxJNUxoSytDdkJDUk1uREVoYWZM?=
 =?utf-8?B?eHI0VXlqR2xhUllWVVlVazlSMElQOUNYcWZGcjBaRHZPcDFYZjVqNnNkUE9w?=
 =?utf-8?B?NzI0ejMvWVZtbzJzN0s4SjJVR3ZRUGhJZkpNT0dsTzB6bUduOFE1MVVTVzlY?=
 =?utf-8?B?V1lWbVRwaWFGWldGc0I0MHR0eU1LaXp4TXFuUmxYSnI1cDh6TXA2QVFWR0NV?=
 =?utf-8?B?M2ZDMGtNMGlPd2IwaVVmQ2Q4OWJiN3FVMGFrcEtFSUJFbnFLMG1jZ1VCaEpj?=
 =?utf-8?B?SkJzMnFaN1pGS2xzTENleXAwazBXQ2FZY0lCL0R4Y0x4M1lQYXlHck50NTgz?=
 =?utf-8?B?eWNmQ2RaOGhXeEFrbHN4NEtyYUM0WW5pNjYvdVZ0dVBWSCtibTlPcXY2VlJL?=
 =?utf-8?B?c2lscmJDZTQ1V1QxeFlGT3JaRTJlWE5xcHc2NWNGZFVOcWRhcDd3QlYvc3Jh?=
 =?utf-8?B?Q2tNc0RpUm1saGZUSlZWSUFyLzN6UXB0Mms4bnY4dis5L1pqb21YRXBPNmRV?=
 =?utf-8?B?UCsyOEpETS8yVVNxL2lWNXdFdEsvNWZGWWJwcnFSR0t1ZWpqNi84dTJGdFNw?=
 =?utf-8?B?QlRteGRRZFJ3YVpvajlKWWFZWTh6M0ZaZ0VkN1pQWkhBdElQaWsrQVdkZmdi?=
 =?utf-8?B?VlhvVFF1R3M1VVl5M3FvL3llQ09NQWtwbzQ0MjRFbkRiMklNRSsxVmJTVU4x?=
 =?utf-8?B?T0FLYzVEMXl6alNhWmdscWRleTFoN3pBN1BicGc3Zy8xQllTY1ZYY2VIdjZT?=
 =?utf-8?B?L2taUFNZTFFNbkdRK1dQeFNEN0NFUTM4OUZRL21CRmtDZUZEcDJhUlBoOVAz?=
 =?utf-8?B?MkRsRkVTUUNRM0FMMi8wcWdiMHIvSWZJSkJPL3JHNTlNYndGOUdDaTMxTG9W?=
 =?utf-8?B?NDMwTmZpV1Zhc29ybTlIenNUL0dDVnVVWlV1cEJndTY4aXMwU2FyaXVOYkJ4?=
 =?utf-8?B?cC9HUHVNN1ZMeGlBa2JlSkFtYkdXaVBBMUtMbk9OdmgzaWVtRVhtbElVbHBz?=
 =?utf-8?B?emJFZHcxWDJvNExQNzVKRzd0dkhWNXBOaWdxVHd3VTdNeVNEU2RMOStoT3RR?=
 =?utf-8?B?ekxzVk9sNTNQbUFLRWp0U2duRGtHbDU4SXVZY3Y0eVNQbmV6c3JiZjdvUVpF?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2b5145-4de1-4689-eabb-08de0db0dc7e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 19:10:40.1311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/hh+/5mQeT2Gy6nYJDGBsvK2KPzHsTPKMObWpuIQIdky3McGpO3f4zSiawy9BYwo6goIyzvPfKbFRkLMdyWaaY+tD+psiz9TveGW7RFY1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5296
X-OriginatorOrg: intel.com

Huang, Ying wrote:
> Hi, All,
> 
> When reading the documentation of PMDK (https://github.com/pmem/pmdk), I
> found that deep flush is used for data loss recovery in addition to GPF.
> With that, we can identify that a file isn't affected by the GPF failure
> because it wasn't opened during the GPF failure.
> 
> However, IIUC, the Linux kernel doesn't support deep flush (via
> nvdimm_flush()) for CXL pmem at least for now.  For NVDIMM, we have WPQ,
> but it appears that we don't have that for CXL.  Is deep flush for CXL
> defined in some spec?

No, and I think a dynamic "deep flush" mechanism is a mistake that CXL
should not pursue. (personal opinion, not necessarily opinion of
$employer)

"All storage is a lie" applies here in that all a deep flush mechanism
does is maybe reduce the occurrence of dirty-shutdown failures. It can
not guarantee that some other event causes the write to be dropped.

CXL does have a Global Persistence Flush mechanism that fires as the
system is dying, but it is not something that can be triggered at run
time.

So, either the system has the reserve energy to make sure that all
globally visible writes make it to persistent storage or it does not. If
it does not then it had better arrange for those failures to be flagged
via a dirty shutdown mechanism.

If a platform fires dirty-shutdown events at a significantly higher rate
than say the capacitor-protected write-cache on an SSD, then that feels
like an "improve the hardware" problem, not a "teach the software to
chase writes with a deep flush and hope it helps" problem.

See discussions like this for the last time mapping pmem deep flush was
attempted to be mapped to storage semantics like FUA (Force Unit
Access):

http://lore.kernel.org/YtefnyIvY9OdrVU5@infradead.org
