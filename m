Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BF637141
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eojcmsxe"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210C8D3
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 11:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696876597; x=1728412597;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KwIeqAhrca++fc8i/fVF8327KUetpxxE+tC6AiLNNoM=;
  b=EojcmsxeX3+uzLzice9Nh4e4y/I3/vrViF/vjwIOtOQLGv87j1FAh1km
   BsDe5h4z1vug798jLFYOQCSUSpyTGc7LkMTAOuMwLj3WswG5WWWdXcIWJ
   aUOvf1PZ2ZYPM+KLaEHj3l1F4XmZKK4UbcZl5tMx5ljpWrBBUib7JPkXm
   uU2TNyR6x7arh1eCxYo8f2rEmHPkqPmT8ouOSNU7P9aPTBSHrNl/CW3/S
   zHUdWW0Pjsa4hTazoPcTYf8HIr9Uw2awumltwW5lk0a5fYmiPbc1UxQ/L
   qZDFwTc5ZcqxzmJAcBivjiEo8wK90vxwuEdjVofbQY5Jzs66+Ect/FgMB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="383092776"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="383092776"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 11:36:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="876898318"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="876898318"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 11:36:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 11:36:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 11:36:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 11:36:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acnPfi8MEB7IV0cUkKRckbGZVi+PhsaRn1RDLvvhlNn0X54Sp3t6BbC/hev9ej3IEIUz5FmI/dIYUTMgk+4ea95k4Bv3jVwhWHJKufk0WkusUzXHPRECao0IFBdkDyD0wtw8ptevkJuHpmgxGh7dlrE4B5Z2tsW85/8OaMl+FO2k+XnsQBhuqx2ZIMXwkWDtcX2u0VOD1P8cC09oKUaspq6NpwHPkkHBOJZDO/tZHiNThE/lJgToBJjyIe6tSpUFN+O4siSpwpkvFXjIcXYgo3pVhwTsIIuOCKgr242GUzQwxd1bQ/Q4la/r8nPy5j7JejuxZXAaJvX1YGNashqQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP/uyLWCldFM9Nz+ZFvZN7obdhZjdq1ZVCWl+2mG04A=;
 b=l+EdUJeBYhhqUspN+x27WCxOJuPDEuLVItWu658fqLuhXhxqnsgYEbMPkdw6Juk/tNRpJrD1yLJ3TzY9deliGGHnNTKvxzFLxHg2/l2ON426eeFaAZi2KmHniFP1nx81CZt13TKZhzrYUSYkgHhs1GAIax1And+r9BPBUTNnMhyyzeRHw0CHBcja1NYQkEU3gGy5ZZUQJdMnOXUpq/vi/I/r+bTkU1FHoKD3lQw2clVPutodpH40uOjQjWX9MWXSo8VAbwpJquI6EnA5hdhq2CRCGR1DRqdP4Ltu6/3o6/7EH/oXFtzSxZicbZ+9lIEz4Po6eBZSUkLH1eccZTtmsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7082.namprd11.prod.outlook.com (2603:10b6:930:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 18:36:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 18:36:27 +0000
Date: Mon, 9 Oct 2023 11:36:25 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3 07/10] cxl/memdev: Fix sanitize vs decoder setup
 locking
Message-ID: <652448294503e_ae7e7294f5@dwillia2-xfh.jf.intel.com.notmuch>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657719974.1491153.15276451196916291864.stgit@dwillia2-xfh.jf.intel.com>
 <20231009174624.00000bd7@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231009174624.00000bd7@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:303:b8::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: fda6c175-d5e7-42b0-baa8-08dbc8f6a617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6rUVIKcR0wIkfPUXH08REl5bEjRzpbR87zgjNHmn7WypmHfpXZPIM3XiWA7K0zJvPa+w+U/l+756P4dDE7UIDpNuzzXKliHR2uw6z0LqCnwCa+fagT7muwwdgBTeZ0VLHgOWfkVyQsOBvcBBlfZPfP7L0qluLbucO3NV9CioR92/1v9JXT3E4haJw7JJvzA2H+mNS/pfM+lpiEQffkx6IEvTLAAFy5u0CsYaltFvwPvtOm11so5NYv08ozbouteAguFTF60ekqV2hdmgCvuvV9quOB+3BcWDXX21hNS6GeREok201RWpTY+5WN71+0dPNNG8NEUMqu3R6o/v0wsnBlsvi3Yaen9NN/8wsMoF+H18W1y3uA/4iOBh7y3Xwd5YjLKv/2mEsj5UGumcHS9LGPgqjkoo3Y9GCxOrHnmCApmf/Wug/7LDba0d7Lv3JKl1j0pqDnIuD8ibKpSRduBqqhzNkVyQym0NhA1GDvHy6FZ+XvuaI113qE38FNHfLo7RjHoR1GlFy5RIBhTJRjwSzAq2wOBVFRFWuo0hUN37/sTK2TmnL/28e7CgEuy1tC87
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(26005)(66556008)(66476007)(316002)(66946007)(83380400001)(110136005)(4326008)(8936002)(41300700001)(5660300002)(6512007)(9686003)(6486002)(4744005)(8676002)(478600001)(6506007)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?43+jAvK4BpA1jY9gPKRS7mtllfi7rRUBUlSWRQOWP5YL408ClDcmGdJhcgRv?=
 =?us-ascii?Q?tVKXtZ4x+VP8oQtdxBhbSvPFc1NxcNtQwXdkmxNvU45fOd85hH0ihgFZ7ANR?=
 =?us-ascii?Q?UdYph5NkJFc1So0DScchHxTbCic545zGB+SczzA2YixYiOrcYLhNJyydaOYq?=
 =?us-ascii?Q?eV0jHA4WWoXKwjc7P/tnVxKWVPb2jfhKDZkcl/MhvkaqgtD78NCbANLDlP61?=
 =?us-ascii?Q?pbOCahfd9ueng8CVVjuA3AqhGAfYS9//UnFoHZT3aUWRO3qCMlXNKRqho4tE?=
 =?us-ascii?Q?0/bgMJrjc/tZfvMtPUiDmaN4tGJsvd+It7SEwfeVXRW+C4cDHLk9VNgmU3Fb?=
 =?us-ascii?Q?QOu8oTMXgV1gOh7NYuNTmXbSYPcH+bwTUmxUG/vHtxjxYZMORubo+5S01qAs?=
 =?us-ascii?Q?apmJ7TjKZoWgawznb1U1a2rlb4dYePEk3xayqUMEMhai3f66AUJ9HJ4OaAdF?=
 =?us-ascii?Q?fnoXt0DXnEMSN57oDBUYpQCg5OgUQGNXYZQNWNVVPMXox/jD5OGg+x9/45BL?=
 =?us-ascii?Q?Nz/JzWpSmH4C/PDOnX04iGJdmkto79Ieh7hF4+6xrnyobg7WJc8gsYfJuct4?=
 =?us-ascii?Q?U7F64T5QzaAh/3ihaJ3o9n45+FZ4K14EMbQcMA0UyS96YICyB9MvEho3xYZX?=
 =?us-ascii?Q?jXOt6pi6DQiCoMLacFnbszquJfmu7zQV6csIWYQMhsjQyv9OqAP94bieQEL8?=
 =?us-ascii?Q?zvhS6r49VGLZnS0+hJCZ+XG+5Dnb+iMhxwfxOIsY9FfOpLGSL+BqnAjHI4h0?=
 =?us-ascii?Q?36D0tUlTS7PX7gPBZd7MXgVQggKFHmTUiFKDxf47C8gCEZZ1krr2D8efjLLF?=
 =?us-ascii?Q?FrgjeX2yaXDXe439wgnU7Qsa5pfGABUz9Fs9X30YoMcGGu1b8kSE9qvATwYj?=
 =?us-ascii?Q?TAV/B3JwfWlEUudbcPiGoUaDMLO4zo+lce0hLJrPlpA0dFK2+rl9gezEK4Jh?=
 =?us-ascii?Q?JcH2Z1cBF8rgUzmulH1e7Vrw9ZweXBoCNbNbfOSyqpuVq3RgrgDYJgND3SdS?=
 =?us-ascii?Q?GXJEbAgl4oegg0LptGXiHQXr3tzjtp2HgCdPAc24dlqnSSWV0M5xd5VHZxt5?=
 =?us-ascii?Q?Cd1qBss4RcM8zeqE2pKLI14dCL1/hqmU1AOhmVuyfB+MVVVcSiN+ygCrwJCY?=
 =?us-ascii?Q?1/0zUU1hH/GfJ3JwY3Dw7EOcFVC6ij2p4LYtiVaeP3IH1K5O7s0iR5XbItUf?=
 =?us-ascii?Q?A7UyTJtNizS31y6/267/m0zq+XFOMz1mSSGZOgAyykkYFQu3DOYJEhW6IaO1?=
 =?us-ascii?Q?1DDTu470qIIw+8hcZdfL8VjeYC2wHsiFOCKbvG4GAY8G24RLgvUTM1E4iZt/?=
 =?us-ascii?Q?4O2TGxXYmYFNmjDrL0q09P6TQneGUWO2nSdc38os5EZEefLrQY2mtV3w98kW?=
 =?us-ascii?Q?Ben3edTbn7rkpPC7rsaC8fkv/4yXq/fJr01G22OACSZZJqWkb4o1jPyp0KVA?=
 =?us-ascii?Q?Fyh/rffmMNGWXH9d/CJ83E8Uc+Qa/PPa/rLmSvvf7Nm0J83e+b9f9GrmRaNc?=
 =?us-ascii?Q?FhufwERAmXS7roiwKIRXvF9qiL1zCHK/qQTgwAd5C8BhP5pMb7NGxjSDoXiT?=
 =?us-ascii?Q?KFMtuQd5FWKHie1uomRHsHc1lUVsCqT2gHwLDRu6g8Qv0OLOAn8VnVMaoGf5?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fda6c175-d5e7-42b0-baa8-08dbc8f6a617
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:36:27.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2aiANA09IVUHVvcB8nRATruDplsZZ6Z0MbXe8+fls+LL98V0lSEH42IykbDofV+tABWUHlM6WrAFHalYTqyzIDxCAhPS2ocGSbWtYPnwLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7082
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jonathan Cameron wrote:
> On Fri, 06 Oct 2023 00:26:39 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The sanitize operation is destructive and the expectation is that the
> > device is unmapped while in progress. The current implementation does a
> > lockless check for decoders being active, but then does nothing to
> > prevent decoders from racing to be committed. Introduce state tracking
> > to resolve this race.
> > 
> > This incidentally cleans up unpriveleged userspace from triggering mmio
> > read cycles by spinning on reading the 'securiry/state' attribute. Which
> 
> Needs a spell check.  security

Fixed.
