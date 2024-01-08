Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11CD56442
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxFeqSiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704748457; x=1736284457;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4w2aE8DdoGHD+FL9Vw5Mou4FWC97mGhZTtyleTYsd00=;
  b=HxFeqSiOkGwBAo0ws2DS3TpAXuVZpYkG311mWZrHYY8arvMOZpr/eowN
   BAg21SVDqVpxWpZj0ZodoFZagN5BtEfAwsnL/4NLLUS9+4aSo6C0xzTMu
   f2nvqrkRjxrH6aOXGQrA+7w/LnmqM8Ch9Ho3Qe9vyMKcINX6y4WQXHfFy
   zZ+1ubWSHAybUg+QCpkbAAA0a4rqOUHWc1BGcT1M6akZ6dKd5V8EKFavY
   OYcD2F2N8feKWMnDC+SVWfBv0LJXxF3731fd4UF3WTmQWhmiTVJHmXr7G
   RAZymfsXtzWC/Ousd72ta0IpD82/KVkoFa1XZutye7x+lSkMdfDIA/BXA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="462290240"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="462290240"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 13:14:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="23311746"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 13:14:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 13:14:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 13:14:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 13:14:14 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 13:14:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRrozdjtg5PEKVVQIobs3wrfNfSsud/4LUL9ExjQERlBJD34CjGMZeZCIbYVCwP7zdpkn9fkb8nz3GOLmVV0JwWeh3bw9YEUcfcWxW7AZGBzwuy98X0LXELn7A9aCdz81TFIs4jn9U2n8t4GnlbAyd6y0di92col88KQTi9yytFBJ0XJl3WaSw21iXmpJVDFiuXjreW30WmJWBW59WFG5IJPjOzTNQ3lSurptUAI6qeWjkDYrnFEMJhEkKbA/prO7Ts02hLrdPTrOctvp948J1NDOS0n8ZUeeKxvywLBhYmRYCoZ0KVlBoiDZqc4wjMXIjl7UrVfFAK7jiAmSVWgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDP4lpOoZhXUpB8EuNAzF28947nopPTZ+IKMYaK5zho=;
 b=nCzGRV1Yx2mBmbE6aa6DubLpZa11wiZdwIraKJQTtMi7VczTUlX4blmUsh/197Jj4/es/OpGOtT8CmWuLxmnU4teM01qPYDePGffFaxX5YNoLXb72ERvFS/k9ZBFOJsb9yBsN3cTVc3aDxtWHjxqA1dVj3Iq7QpHP7qFAzqmnS1HYHKYgPtWGrBjn9E9ML4UVijzhrmZ1N06S8MHxmBf/jmUDzKg02DSAzXW2+6xELEj6yug47I+1ZX5ABCMAW6iAuBy3nbZDzRJ5qj07tO/lSWrO35iX+ayaDKDPI7lXEPfWiM664B2ULH9q+RcPYtO97Rd8mDcq6a3tSyDPSmbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7720.namprd11.prod.outlook.com (2603:10b6:510:2b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 21:14:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 21:14:09 +0000
Date: Mon, 8 Jan 2024 13:14:06 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>
Subject: Re: Some thoughts and questions about CXL & MCE
Message-ID: <659c659e938cf_127da22943b@dwillia2-xfh.jf.intel.com.notmuch>
References: <46c10608-fd28-45a6-90bd-28c1b9678af6@fujitsu.com>
 <65958f44d67b7_8dc68294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <20240108123749.0000027f@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240108123749.0000027f@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:303:85::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: d9aa1467-9fbd-49ce-d731-08dc108ec0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECtvWh0gEyxGhgN0sGBNrjHIt2YaN7iA7BuRfntle5mGqI63oFZw4I1fk19IPomgoCpRrnyDPw7IwULrK8u1HHVZ3ltpXEE+ZZ04NQlgHu72vOocV8nMKUex0QNXN9mqkuNKWSVSTCsMA1/QvMgvHZRpIv4bByvaJpN8ymN1lmaRfUqVQdxqxYWK7tYX3+cwp45MXLSuxBrMp+FSb7SzRzxFsN67g6hvU2QvW+OdErXRmHx38pMCBihP+vYEJ9vBNOipH2QbPrULDSjYlqdQmyL79NJz5KXc45FXT8TMOtrlq41afLu9Cxn/L7O2flDNfXmj+lLqqGt0uGF9mxXSZFx/fPPWc3NFSkYYXpUwwzaG5gSZIvXWech2GioafU6W2IqdB2PQC/UmAZz+47jIzqxwJjk4KhH7FBe6Be0pv+91/r3fyoog+GJVIZguNO8EqVFr2K0RfoeGLj1DV9DppO93mad8a/tZfoQnf8E55kEdQg7pX7dUCen8xx9/89+9e70ybbUuQsoZH0HzWoVtLHnATeJF3/qKdEEMvdIA2s4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6486002)(966005)(9686003)(26005)(478600001)(6512007)(6666004)(6506007)(83380400001)(107886003)(5660300002)(2906002)(41300700001)(66556008)(66946007)(316002)(8936002)(110136005)(4326008)(8676002)(66476007)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U/3mfDAayCUSCO/KDN3tGzi14PPr4Qocf+clfw08UV686RzraeT2uyx+OIE4?=
 =?us-ascii?Q?3ZFcBzqc8VKk2Dr/sdDTo8WzTP+BV/026k/poEc8WgRispjyBpNTaNdlrlyF?=
 =?us-ascii?Q?KW7xZxmZ/W6He6X0JtkJmyPpRs5QzaH/bZ08bHmOPkYqwOIw+efFgDn54JEl?=
 =?us-ascii?Q?ukbwIbjaf4j+idEPYUBjusoqM6WbXWVtpZAW5EkYK3J1sU58iK91rL18WlQg?=
 =?us-ascii?Q?KRBxBtCGFqa/38Qz4joF4GtG/cXLIaQEkD9ASyuOErVPrX4hAo24/tkQyD+S?=
 =?us-ascii?Q?Vi0YFUDAhbk3aFam8WavBuAreguZvDKOzsETFODHt7aenMp1DBsRfwlDwiOY?=
 =?us-ascii?Q?7m7spVhVWJ9yua0mwQYURWq791IZny4BIfyeBrUcd1q3Jz8jxs8u59wqy+zS?=
 =?us-ascii?Q?gQorPR9fTx5uwY3QSN3cVT4g1ucrZgn9mjZIEsy0K3ojrWDRTZI7JFNc4BxX?=
 =?us-ascii?Q?AZLUI2/DgVwTtkeSvPaY6/0FT0SVblM3A7uHYR7dUsadqXhGOHaALN/Fgn2i?=
 =?us-ascii?Q?MTmdYo5nIo/PxuO39ILCbqaGCVgLvtN1asYXK8AYC0agFEZCPywMIJ+M4t8I?=
 =?us-ascii?Q?I6Qa4/DuFStrUzOT4ALsm+OaYroNnIuQsBaBKIMbXRuHCkMYTJ2EURjKkjsv?=
 =?us-ascii?Q?Q//FpJYnS9p/qGVaX1VCNRukyqmsdwRWTclojDZnFXA/NV8IBXVHaoY8/EIt?=
 =?us-ascii?Q?Vw2bQHtQV3GxwLWvEcgkjwY1QackKgPvNDiBi7kTdCdR8uQsXNm9P8li9ZPf?=
 =?us-ascii?Q?pZ4UL6SHJ8HJ3f5VnH6Hm31MV6wpHYlo+Ig7cD9oZzvd9EipXVa++xAC5mwX?=
 =?us-ascii?Q?dXRcOBmzBMegYXipwrr3sdWPHqNuRYR3daDuuVhUSp3GNN5KxgXAFdINUpwb?=
 =?us-ascii?Q?tl7jewPIxOgjoSdldjoB+Kp+SqiqzhjsZ82LwvUKIs5jgGmJJ7amhzlqTQNX?=
 =?us-ascii?Q?1oB+cq94e14lPqT27H68qYWZHXJ18zF8REnaKYDf1Fzwg6KmEbMPLMlrgtyT?=
 =?us-ascii?Q?EUTksdhB7B9rQkB8+5jLegQR+rrmZhmVyyGvIlwJWdcjESrUtcVnzw1y+fs1?=
 =?us-ascii?Q?c44aSD/MTYgyG/N+JYxw5v4u2zKRN/ZiQHsQXgS+M7YJR5gqOYjWEOUJu574?=
 =?us-ascii?Q?2OamKVYcrBb9O9JUNOm076ne5MkZiz2sFMBXdJO0fXWvQ5mwvHeV1Bi/0SQd?=
 =?us-ascii?Q?R+Z6qu9pElB0RRFsIgqhIfzyGpEf7yzTG+Retp7FBBGS+EH9DgYSCCFVTeLc?=
 =?us-ascii?Q?SqP1WfJ8mVvXUqZc6idNGr2D1JkoGuyMyhgiFc50Ar/H7FV0HvCjyCW7MUix?=
 =?us-ascii?Q?AFS7BNeqH07TFp8ygGfRDQOgbRF/c0lEvdp4gbFgohjnQ0M8MoRogd1kWwbQ?=
 =?us-ascii?Q?sAxNSzrix5ausb9iBX1uZpv7qYR64Djzv/84x373t2EmSjIBDlODopQNFeox?=
 =?us-ascii?Q?PfCXp1B/EfJRWpWY+biNCooMsGwcOlRcOGBHCZnG4llJIo48s8O+0pOwFFn8?=
 =?us-ascii?Q?IFzmivxUhc3jbofHpFkv2qGEaKiB0Je9xGKjfiVAf7S8rgm+iuv4IfcGam8t?=
 =?us-ascii?Q?yST93fReGtcu4GqnudPeafQAVT/KM3JUwbKSiUe6e6IYkut+uYvFN8Dyq/HI?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9aa1467-9fbd-49ce-d731-08dc108ec0f2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 21:14:08.9547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOjAMMKsed+iCYpMLAlvE+YgSmDHA/Pgj1qjfW+ADYsa1yayYwMliUCYRY6TPkw+N2MhKEbUFAgK1qJfR7uktSoqZmDj6LMj6i0WLEUg5LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7720
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> One other wrinkle I'm working through is the control of CPER vs normal reporting.
> Current thought is we do what ACPI allows and start in firmware first, until the
> _OSC call.  If that requests native handling we go back to what we currently
> support (native only emulation).
> 
> However, there isn't a convenient way to mess with what Linux asks for which we'd
> want to make it easy to test the handling once the driver stack is up.
> 
> I'm not sure anyone would be keen on a pci_aer=no-ask,cxl-mem-error=no-ask type
> kernel boot parameter to instruct the kernel to never ask for control.

I just expressed a similar lament to someone else asking about this, and
claimed that is up to the BIOS to say "no", not for Linux to skip
asking. It turns out that the Linux pci=noear knob predated _OSC:

   7ece14175376 PCI/AER: Remove aerdriver.forceload kernel parameter

..., so there was legacy to carry forward. Otherwise, in a post _OSC
world it's the OS responsibility to ask and the firmware responsibility
to optionally say, "no".

> I also don't much like a qemu parameter which basically says 'report aer as
> broken so the OS can't grab it'. Anyhow those are details.
> 
> Ah well. Getting the _OSC handshake to save what was negotiated on qemu side was
> fiddly but I got that working on Friday so I have all the pieces for protocol errors
> done (ARM only for now - I need to look at notifications in ACPI on x86 + enable
> HEST in general on qemu-x86).  Will post an RFC for ARM shortly.
> 
> Bare metal will be burried in bios config most likely.
> 
> Jonathan
> 
> 
> > 
> > > I don't fully understand the CXL spec yet (it's difficult for me), so 
> > > the above ideas may be immature, but I really want to figure out how we 
> > > can make CXL & MCE work.  I'd really appreciate it if you could help me 
> > > on this!
> > > 
> > > [1] 
> > > https://lore.kernel.org/linux-cxl/20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com/T/#u  
> > 
> > Following this work from Smita and Ira is the right path.
> 


