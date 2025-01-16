Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CCBE555
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jan 2025 03:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736997205; cv=fail; b=XxCQVJciQgvwBRwzj9qe856aaAZFU8BTWKizkx4RTdo3TSKsHt3hNZ3Zc2Ag8Liuyu4Olam5iUG0tFxd7tEstoZBODxqZRyv8Y86xjqSE06E2NvcbzfE64nj1tIAUPKKBpBJO6/TJ9zP/qzZC+bI7HJQETL1MI8lO22l/VUIHLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736997205; c=relaxed/simple;
	bh=PDeMRST+q5FqaArBI6ijXViXhu3W+5EYPZkwq/r9CFM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FUL5XZbCpFK6CpES7Lq492deXpEGLnJr728HVXbCt+o67QodtfemtAeJmHkgjdAuspvdx002DNcZUpaDE32j4W6iWVYZ2pyAfTMVxQIm7p1O4nDc29bRRINi2caVE1X6fBrF44x1FUDvLPxGj906cYswJ5GalPdmftkRi34TmxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8HZtRjy; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8HZtRjy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736997204; x=1768533204;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PDeMRST+q5FqaArBI6ijXViXhu3W+5EYPZkwq/r9CFM=;
  b=Y8HZtRjyENk8FuAeVfxaTcVwAfKt4J88RHXwCWtZ7g5s6lnTV42g0wIr
   yFd+5dHj/peyu83nkb5k8lpruwGuCc8Rx/IsZ8p8hyU4PsHCywzCVG+c7
   1AJX2j/ogNJCVO0LAethlNNBcsQNe07/2DMqY0COJlKm98/vUHJVLBXWk
   bhF3lz4F8cKvDCVXA6aaDzKZ7rYL5M3TDOziO8u2d8EJLfr37LtVhAjFg
   dMigvaUB0el4L4jKKzMkmfZyrjsR0A5VsRypqEvJHHeYvNju74o2EJP2B
   QXPF93nIa5ecfrckSE66KZAORDeB0jee2lC16J8ckRHlLSFOViRerY/k7
   Q==;
X-CSE-ConnectionGUID: RHMYji0HQNCHe7HTrQpHsA==
X-CSE-MsgGUID: CgYG4+aBQK2BMVdSXrdcIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37521105"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="37521105"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 19:13:24 -0800
X-CSE-ConnectionGUID: CEEDRiUeQEGXlG8onCQVSw==
X-CSE-MsgGUID: xVJsGTe0Tb6jGxt5rRyM5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128596000"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 19:13:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 19:13:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 19:13:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 19:13:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+aJEmSeW7MTBx6oQ7ljc/gGgUr8NiMpePHfw1In9a3IbbVp4HilcQJ7lw4VjEPWUpqD9Yi1dBNOQfy3vGmwIYz0vv6dSKX6CsnY02o9/MV+knq/foAxfozshNooMim/BLO4XqyszdCHPRspQ01MlLFfcrRskbBb89fJrneMkgaoke+w4CagMjhvh9f++e8x+XCsYe1u2zRA1YtD/6taQ46ygAAxxPVbb4MAgwVuAi9EwnIi5aI9rsPx6kQ7/SXZrsemWJPH2er8AKer0Q9TyYGkwabCZoDVZLu6YtyWsiMsSf3R8bjS1a7zdPo/iijxMRzoH1/PPQoB0DI9y9ZA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2kIb+0eFI2RhM2o8IgNNv1N3fi2mDeQmDXiBKs+rNU=;
 b=FKhxYPjz3xEOko1kiec2BxwprjHEqsaTCD9hAUzg88D74ELnyOj+zVzULVdDoAuqBSwZ9QSdZRvemUuy1D2+sABNkimvpa2Xd/bUQHdDvjyQr+2XjKfysp7Gyby0o7LzvAENP3bE+mrVXAuyJtEdHP7giOllJgkYzNvy/b7kcUBzc/5Lp3dvFkbryKxMbifQeDsXijIP87jL060POhLFVaocdsDbAkY+263TqLuWXdvjWysjcuVXbdcpabEovi4cL7Oi2nrJv7Ka2eXkwDxua5vCPaf6ohnfd5mkP2Iw+GL0nhcRUcdmqaBc6xdDXpuxlzPoRanVt1M3MQSEEQVF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6921.namprd11.prod.outlook.com (2603:10b6:806:2a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Thu, 16 Jan
 2025 03:12:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 03:12:39 +0000
Date: Wed, 15 Jan 2025 19:12:36 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, 'Dan Williams'
	<dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "mj@ucw.cz" <mj@ucw.cz>, "Daisuke Kobayashi (Fujitsu)"
	<kobayashi.da-06@fujitsu.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: RE: Unable to display link status of CXL1.1 device (RE: [PATCH v18
 0/2] Export cxl1.1 device link status register value to pci device sysfs.)
Message-ID: <67887924b1f8_20f32944d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241002011549.408412-1-kobayashi.da-06@fujitsu.com>
 <670efd5389f6a_3ee22949b@dwillia2-xfh.jf.intel.com.notmuch>
 <OSYPR01MB5352F167B18CC4DFC908D692900D2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
 <OSYPR01MB535257C0AE84CC123A656E1590192@OSYPR01MB5352.jpnprd01.prod.outlook.com>
 <67882c522a8b8_20f32948f@dwillia2-xfh.jf.intel.com.notmuch>
 <OSYPR01MB5352795A910A843A64D4E61A901A2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OSYPR01MB5352795A910A843A64D4E61A901A2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:408:f9::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f03fdd-79e8-46e2-3603-08dd35dba24c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qAYfFfSbnpjP4RH5tZo7QcwUPGKjS4Yxbtm63/m9Pwe3BYXx5YRyQxD9Abrb?=
 =?us-ascii?Q?YVgbXx6seUh1MUMiOXkNuLRKSS1+vYpsnx3S1p1NXHj9Wf342yZbulsphiBa?=
 =?us-ascii?Q?+TXi7HFrKUwn8NJWlk/rtXcM//Lr+assFHLab51UytAPC3qpDq1h9lSVsehx?=
 =?us-ascii?Q?9rlxcSm52pJIur7V2hzvXkJFr1C2HQDBuPsPiULWHMR5YWJKSICO48YuWIpz?=
 =?us-ascii?Q?H3qvo1lh6RLtdc9ZjYI1T4sqWfzx7fl1Dn9nn2jRNZCIs4XEhrTXaYMzbXER?=
 =?us-ascii?Q?/7aloWSZvd7Z5WHATV/8qcIHmEae1SwvdM2+4MfGoVmwL/m7LvOowFWC0fPK?=
 =?us-ascii?Q?jaujjXQNCUYGKod11+rRj6wKt1lDhOMTv+jNdCi7IO1DoB1D1BFlJJfXliYu?=
 =?us-ascii?Q?p+NZGuFUrUoJU+SwuSwj853VhgJ0QzdclOVfRv2dCqKOkZqmrXiJcpfRaruM?=
 =?us-ascii?Q?Vwy9lgROCrw45QUnnlWrXkAlebtaRJO19MjGTvCMscfABtC8T/O083pDwjeS?=
 =?us-ascii?Q?D8WuNalxXO9HA7EKPSCAgZsf7Rc5Q12gG5Ez3yBEArXCNdEE/QUPjnFb5mwS?=
 =?us-ascii?Q?Iz0BlduQPQXRxifkday+tyTOATEQSp3yZHm3yeUV7wJDHZBRCvmyWbu9zSHn?=
 =?us-ascii?Q?Ql0L6KKlQIceREn0lIPOpiy9t5ZQ0FzThACdD77mzotuI3krJa4FXofZswIn?=
 =?us-ascii?Q?6k14NsvD4WM1iPqGZDTbzcNEy7KvdD1Fd41HY3GiItqfaYgMCB306iCy46XJ?=
 =?us-ascii?Q?76TORiYfrMwVm19tyMaFKDTY+W34rMZr9US1O6tJdLWt+0mXVyAnBsJJEQVh?=
 =?us-ascii?Q?gP1CuRPmoxdi5Ung2qNBd5G1t1oTfMgIT67WNuGq6JGyCgueRi4gRjvviNRQ?=
 =?us-ascii?Q?26hc8DgHvBTFIfqkNJyqAoqjgB6MGgVrv36ujCBZ2B0xVxhcpSjKvJpO4U2s?=
 =?us-ascii?Q?TrL+Yjb9DIdGru7xW0XGlvuP2+A+lBkKt8Izb+9ubpxLO0GVeDddXsRnRuwi?=
 =?us-ascii?Q?2cWVx8piIGB0YvbHJMCMHAdglVTRZswhIfk5f94q7HFn2raQudxAiaxk17mr?=
 =?us-ascii?Q?w91pYZt5XrWCE9hs7qhXQuzjZV/nBcmyMTcJmDH9OG6Gh8z3lPX2MbBBx5eo?=
 =?us-ascii?Q?cqxTdtzHOXcMD4UOt3oOsuSYUXudzyrmpe6+SLeeVjwQKIF2FC6SYCgB988d?=
 =?us-ascii?Q?UygbXqZdaaHT1c7oUwhlNg8Uf1d/U3BhnV3ojUGVDyeukjJVNk1l7PdAW8NH?=
 =?us-ascii?Q?q4h/TT3Zm8JZLpwWVHHRw6sdJHGReDxMvMezOCDFQCYcrpacifdQn5lS5pi3?=
 =?us-ascii?Q?2YAZV545m8wtdcpKA1v9/uD7ZXYG63v4JBHyrV9GEUuAjc6R2/NF2S44P0Tb?=
 =?us-ascii?Q?1GxoLIsneFyGGhxSvXGLtpayNraM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQtB+3XjkwZjG608b+Okj6rEh0N0+8YJq/5rDfxxhLEJql1yJSLTz8CjRlJh?=
 =?us-ascii?Q?GBsj4Y4pep0uluWnveFIYVDx+qmo1ufNf9J9OX+1UJbjMdydmNTju81zqN4B?=
 =?us-ascii?Q?6IR+0FRGTf91LNfdP0zDjx2KVpp9nZkAUp/9j+f932w+hLpTN7jzOChcFlCw?=
 =?us-ascii?Q?Ycv6xq8ODPQLwFgLDaDSiix6LgGLA5ZsVUobTC9iDik6YxoQeuycitmqJ9Am?=
 =?us-ascii?Q?KreyjJIW+yDzRZwqDXEicSIxu8TxjzhUGZgjzc4NjKRtBeaUTgvokdy73rkb?=
 =?us-ascii?Q?8/WkeFJ/hg5DgMrSJ18akycD5qusygI05eTmepEShXgEx16E1Lr1s47A/9tr?=
 =?us-ascii?Q?Z0JZwxPmvVSmy1x0m5q60oA6GYssA8a4ytVBqds6mEK7G1zDEjcKrFYsrp36?=
 =?us-ascii?Q?hd8NC5N/4fTJJYBCeNPN2pxX/cvLpio4JaFicO+9Sv1JalAMFSe/7PExAnmo?=
 =?us-ascii?Q?LJ9jq6a2qA055fGFOph66Pg36M2fjp641gzkGlgvNnq6idnO2XkFbX1mQQfm?=
 =?us-ascii?Q?2wZkz7AHZ8q1vWnv8kqyoLVESEVAJZqs1dgLQ321MgyOuHwfFHaTWf/gwEDI?=
 =?us-ascii?Q?sX/TCYY5f/YsbDqId4hwGb284s1EXWD8YhBTCMiF64/eUN3Sh4eTOZZIgfX+?=
 =?us-ascii?Q?5BkebWnQEFXPFe40I8k+KbxeGeBKerl8WaWLR37tPcITTdspwJuKfI0Wqa6B?=
 =?us-ascii?Q?MY8GeYyNbPoFbmWarUpdJK5vU2vNSge+vl5sOGetewiEEdlf2p6yykNFniGe?=
 =?us-ascii?Q?tqbrIo7j+MHVGBMsDA8ShUecSUE0rJQhrC9tGyLl3mQX7IUa+gYHkXevJLlg?=
 =?us-ascii?Q?Fr5qImwjzm4djMhbPP+V78jxu1RNcEkGCF29oIdzBAjnar1WamyJ9elu8ddH?=
 =?us-ascii?Q?7wtaxEh8I2VJWIdjNfOAwE+Nlwu+GLBn1az3YyxJYIK50xEISxRXpYmTvF/6?=
 =?us-ascii?Q?9yCt8z6FVG3iZLMFMjEYMj7MtDooza5WrI0Ju3LH8dTyg96xMRP+uX/fSPyi?=
 =?us-ascii?Q?WfVaLKKmno4U+QQEwc06e03tAxSLdI2bEsnOALguCpB9dsGmhTZaToL3HJYV?=
 =?us-ascii?Q?bgN/HrOWY20969DT3hZU6s6mcVxvuM5EnqyeDyGrXLiWuOuFKem5yTFK2LkE?=
 =?us-ascii?Q?Kz9Qaok/cNupqLBqVig9K7EdRXJbAn7oYWeGs+dltAGB4RWCM6RgFCnrKw/o?=
 =?us-ascii?Q?/jGj4p6tS6eEGELw13F+W3S5ckVHs3bG/MlRjFkhAXpPTsoUIaEEMwDRaLsp?=
 =?us-ascii?Q?w6dyJs7lpjO5zI95GhuBgNara/9x3xvLWsnzBFBRJKO2K9wT5H0cyF+WC6fm?=
 =?us-ascii?Q?agCtILAuvjKpjveazBVeGFEpWFl00qt1uDA6q1xqsJwVnQuET1Dp8HGtrMQG?=
 =?us-ascii?Q?9yo2duEdsN55q3n4zTsu7xQW2Wg/7RRteXszusfpolo526lvHMskNYlb4BeG?=
 =?us-ascii?Q?syYQec4Rb0PUAK+xOSQjo4JmYcz+dxnGIbMw13oNewCJ+eZDG1DJ2351qumh?=
 =?us-ascii?Q?ytkdIO3183Zyvsie3WAsIy4YHABovMoyQiTJ9cGUkTTle7sCxito48ji2vCI?=
 =?us-ascii?Q?kQiGLG5lSdE4IiKBzHiuMrrSqDZX7r+Yg1N9mlQ4mdxPHCOvnymOfLEKYUL7?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f03fdd-79e8-46e2-3603-08dd35dba24c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 03:12:39.4966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpB6Ma0u938UPyACUwTbxpJoIyEJd3TlLOKuofgtfNMb5vzaRNkOL9TEiw/u4QJPPwzA07k2t5zpjrXR5kJbZt16gEUw2MdjG3FL19KzJOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6921
X-OriginatorOrg: intel.com

Yasunori Gotou (Fujitsu) wrote:
> Hello,
> 
> > Yasunori Gotou (Fujitsu) wrote:
> > [..]
> > > > Fortunately, I can use the real CXL1.1 machine for some time.
> > >
> > > I investigated this issue a little bit and I discovered a significant
> > > detail.  The "ACPI0017" is NOT defined in the DSDT of ACPI on my real
> > > CXL1.1 system.
> > >
> > > Consequently, cxl_acpi_probe() is not executed, and I guess this
> > > prevents the addition of an entry to klist_device.
> > >
> > > I suppose that the current code assumes ACPI0017 is defined; however,
> > > it should handle cases where it is undefined.
> > 
> > Early CXL 1.1 systems pre-dated the addition of the ACPI0017 definition to the
> > CXL specification. 2nd generation CXL 1.1 platforms added the
> > ACPI0017 object, i.e. the CXL Root Device via an updated BIOS.
> 
> Hmm, I could not find any mention of ACPI0017 in the current CXL1.1 specification.
> So, I thought ACPI0017 was not required for a CXL1.1 system until received your comments.

It is not required by the specification, but it is expected by Linux.

The rationale for why CXL 1.1 designed the RCRB scheme to hide the CXL
device inside a CXL root complex was, by my understanding, for an
abundance of caution to avoid compatibility problems with existing
operating systems. The best way to not break old OSes is to hide details
that might confuse that OS.

> Although I have no objection, why ACPI0017 became necessary for CXL1.1? 

The Linux driver initial implementation started at CXL 2.0 and one of
the first missing pieces was the lack of a platform device object to
attach all the host-bridge level CXL memory resource initialization
details. The ACPI0016 device was not sufficient, and ACPI0017 was added
to the ACPI spec.

The initial plan for Linux was to skip CXL 1.1 enabling altogether and
start the Linux CXL awareness with 2.0. However, it became clear that
there was value and demand for adding CXL driver support for 1.1
systems, especially for OS native error handling. It also became clear
that an eRCD device plugged into a CXL 2.0 host-bridge would still
require CXL consideration of the RCRB scheme.

So the momentum of requiring ACPI0017 and ACPI.CFMWWS for CXL 2.0
enabling carried over to CXL 1.1 systems.

> I need to discuss this with our hardware/firmware team.
> 
> > 
> > The Linux driver is built upon the cxl_pci driver finding an endpoint, and the
> > cxl_acpi driver finding an ACPI0017 device. Then cxl_mem driver
> > *connects* a cxl_port hierarchy which triggers enumeration of the RCRB etc.
> > Unfortunately, without a BIOS update that provides ACPI0017, the Linux code is
> > not prepared to enumerate the CXL topology.
> 
> Is it correct to understand that this is the -policy- of the Linux CXL drivers?

Correct. The policy is CXL awareness in Linux starts with the cxl_acpi
driver being able to enumerate all the platform CXL capabilities via
ACPI0017.

Effectively a CXL 1.1 system without ACPI0017 is opting out of OS
support, and falls back to BIOS-only memory enumeration and BIOS-only
error handling.
