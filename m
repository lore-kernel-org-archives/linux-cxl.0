Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254F13D559
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iT1tc3gt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704830393; x=1736366393;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mJg5VqGnKdalq02CcPejQW6C+MtTm3mLem3DSTA6KqI=;
  b=iT1tc3gtYcl0E1zAHaya9dBxZkKnVG/e4DN2pCTsM3zXjI+ybOuiByad
   HMk4dipKI/HqaaieX03IGkO/JVcaIMwidsXzn7gSvORe86VX8vhvy60UK
   UqX4k5e8HokAG6BtEf38pF71oTGonKCuWN2Ff+wuLUCHukLF1Bx/HYRjv
   ASGrbZxmvwgSy0toQ1V6xn5s2SqbzdpMt35+nq0eBIn/xEJDDRzrizb/X
   yvvzxOz264XzhAj+xrI64E0BN4P7eD+gxqHkOajfhWMl+Ibu+geyWrErs
   P3/8IQkrUoKVI9Grd5egKBKx1ryrDpipxncfjqX1E4D8vst76ezp9jasR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="395472451"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="395472451"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 11:59:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="955109091"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="955109091"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 11:59:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 11:59:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 11:59:51 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 11:59:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efblt+0bb4rQhdr+RSEE4z0y5SdVH4PStfIGPuZs9pT4+kyJR3RJiGKOyGDISgiAD4bS69PUxPzdEMVZB2oVSnh/DKejVL5MntxVswvY7FcyMGZWERPjZVpZst/l7vh10QdB2QNVJZnwk9WqPcchIm5iYu92m6u2RBfinOAHCe5DukquttYg6Bev9giSvm8/WVg5revXVo++jZjWfQbGDeRybk2W7B2gH+PmjJYe/3gSBo/FBHAIRbm2BDZ9AJq4wuIDfAoPWhDyKMJFKUhDKk/p/oFDJueOzyLWmOdmB9gajIjskhIUyE4vUACYdrt4bLPW63pMW+FZ4/ofKBYAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+eiQ/EIel//3yMpCMLppOUbqnjMPmJkSjXzVZj+GQA=;
 b=g4JEg6TwqPZgSgxMvbDaQajHgppKUI32UP3xTY/bdf6uvxidUdGcLmn+Mx8WqsQbtpEBb2v2jsST6aVoIliiR/gbAtmoK0SBr6caoE9bUxYwHh7MyBojO3LRFUMdd4rKCOEpBLLc44DOrv5/0r78cVaSpqiVmWXNZVnouenRrathLiOSqAQeRisx/G3svrAxrUSUQ45LF+Bq7q1cNd/MLYdEx4ez39n40E5AHpi3RPgO4Sqtcpi07hhTN3ebnscO3eGl04XOCl1OjbufyfiiWMvF9Fw4wiBF4x00NoV6Xe/Y82kuuGlZvXERM5757k68qvHKb1xIa1pNmBWMOayxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6972.namprd11.prod.outlook.com (2603:10b6:806:2ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 19:59:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Tue, 9 Jan 2024
 19:59:48 +0000
Date: Tue, 9 Jan 2024 11:59:46 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>
Subject: Re: Some thoughts and questions about CXL & MCE
Message-ID: <659da5b232ba7_24a829445@dwillia2-xfh.jf.intel.com.notmuch>
References: <46c10608-fd28-45a6-90bd-28c1b9678af6@fujitsu.com>
 <65958f44d67b7_8dc68294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <20240108123749.0000027f@Huawei.com>
 <659c659e938cf_127da22943b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240109161857.00003363@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240109161857.00003363@Huawei.com>
X-ClientProxiedBy: MW4P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 707451af-ff2c-4b37-24df-08dc114d88e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCGjvbUQjW5InQTU9nqTtLuB8dy+3p130GJaGoRRmCiCRjmohs4Z7LJfacGjV2zj3DnYvvr8A35poJE+3FpBRMCQg/L1ouzt18Rxa3qfiG4x3w9kDhIdZV36dS91MQjjkfYD3pRiuavRxKQBr2PZSe0bQq1UQNBW5ZyqfYJu4dpAnBf3UeC3RH8dHcekaufotn4Amr3c3yU7mNIOS41hg38Gq7V2Ah8MczMGwLCA6NyZmZBhs1UeavFtyuvFs0/XAMdWMAeH35QcKIXbm7nsEiEipBdghRT2YaQVC6rMWlF+uZIk5ESOA4yCgtbAenA9MMW46EzShdxBAWdtvBXJiQDa1Rvrwyl5BmzCkQKUaDDUd8xhHBaiXA7+zFPBTMNTVNqR2/vLSOQnWGdtZNfipjujffcIVpuPb4uSza1Pd/P+XD/bdDm58d1+SMwbnJYRRvbsZdvv9n1pnZvx9/Mu83PRcVYJE0rt82N6J/WkExbWF8IHnCjEyN3L1KjGnzt1+dOS4UZNmwFBTWfHvY0Jv8l9Zkw+TGecg6Ug/QxANJYy7hIgIjBBL3Vihk40dHO1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(9686003)(6486002)(6512007)(26005)(6506007)(478600001)(83380400001)(66476007)(107886003)(41300700001)(5660300002)(316002)(66946007)(4326008)(8676002)(110136005)(66556008)(8936002)(2906002)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K2NCrKDsqutmnvd+9PQcMCqxB6bdPsO6n+07IjQr4/bhE1riVXN5XlfeQAaU?=
 =?us-ascii?Q?aF/XXUoBwmaw59PvQwbnN0OHT2UAZbkL+3LyePIB7r+/GCYhDOv0lNTRtL+E?=
 =?us-ascii?Q?9Sl2UexDZH1rhsmwKWKZdqEQJCTKuEORBne+JijH5f3rGUP++NmIQ8QwGPAy?=
 =?us-ascii?Q?TNKpDr+k71GMmi8i9UrI8HaOBYkK+9RlQ8gzPl6Jfp0v+iYFw0ESmYbfbtjW?=
 =?us-ascii?Q?vqp9Q0H8C/HRBiHdXHtkhNoeEdhp0fgjPOPGGRama+rRqPDH0NwCyu50nDkd?=
 =?us-ascii?Q?rfvmiSGaBWxAQtOpOis6Lla52zzMGjh5nBsR+rQRe0f6xwM0kcSuSfQ1I8cM?=
 =?us-ascii?Q?5QbWPJHw7eLcu8aN21jOzvSHYlNRMoxn05pIyY/rGj4keP3E+zZUuoIuwtAU?=
 =?us-ascii?Q?fXK2HhYHo6AUzeEGeh7indicBRW01CZG24G7XCF6b8APmu61IgM6o0JWSw+3?=
 =?us-ascii?Q?+fLndp4Q7pflRKvbsEmjE6naoNPwyqqNnQNBWgVet75KxmJN2OnmczlH/q3J?=
 =?us-ascii?Q?DI1FYwoKjgdONqJfBjJxmc2nySLDxZExfCofVoKTMJBkOK8YZP3sIzt7jHqG?=
 =?us-ascii?Q?4y6s4S3FpuEdLRdedoicDdYHzSboIEehSbjWL7wBNB59oquzPF6QjaDWHm9b?=
 =?us-ascii?Q?hCZVaETke/4M/2MM0hvKVqpZ5lh8lIAOa3ICBzhj5rRBtjMP4oEz9ahf8CxU?=
 =?us-ascii?Q?B9/05UqMtsqNc8CnIDUpnEtchpQ36/VWq6DjRgRJC6u9a8LIYXGR8Xq3b7sC?=
 =?us-ascii?Q?Hmko+gmT4DLd5WWSQb2e4PWREloSqxydCxtwVa2ngSwxnUZxspz0UrIKMI80?=
 =?us-ascii?Q?oDw1zzp1zQDE6tDBXG8TrxgtEN/Nq7MzaJitQnHP9VRiwUtnfz/9f9OnZelm?=
 =?us-ascii?Q?b6G7NKTHPtksaGxK35F+v3z8EN/ADm6fPNEmBWbjFZLqPF7dQnu+B9kUcKMw?=
 =?us-ascii?Q?Hy98f+YkIqkHpId71Plx2fh5nn54dsaiG7naVOaPuz1CHgFeWbB0nE/S7Psj?=
 =?us-ascii?Q?GcYn/8kVt9bBLTknA6ItIzp+JROvjw9AYvon05oygC4729D093aEXYhewVPm?=
 =?us-ascii?Q?tM74Bg/naoSnwASbtztMmYd2YucAGfpZcU0qk/xGeTqehpuGPLYPD6vRKTUo?=
 =?us-ascii?Q?A6uf7tFZb8OEZBOpKUdBZdikrwPSrS83uLs490VwHPZdtCErdQlDFgp9R9yZ?=
 =?us-ascii?Q?/0BNlOfprzop0vqiIAAzK7JxMUUfcGeDlPh1/dBsuzdk/CrQhi6rjJxNg9mj?=
 =?us-ascii?Q?2PxnCMkqbpOMOCquwxFGO5/maXkMSABOjH68YtMUuM1w/9TtauKIsFtJt4jf?=
 =?us-ascii?Q?Vt1iOngDLyZM2/YgL7FS0/DdN7RG4LAzqAYqjIhalNA8S5SiyhNBh8K/AvtW?=
 =?us-ascii?Q?ElBobOpJyE184nOFzgRMENYTbPKmcoE/mm2PdmJt0M23bXq27tGiTCv7wH9o?=
 =?us-ascii?Q?6abOa2hKR8chK7OVDbh2p1eRFJwza+OOF79Vi1kuTwrUX3kloLzXynr6A24N?=
 =?us-ascii?Q?cCsEqnUEZgs4fC4biBcPsFIlGDrh/WDlEGY4DKOPszymtTt6eU98mCrmMH3G?=
 =?us-ascii?Q?oJJyh8ggu4qB4vt0J8g6BTaPkfDMxKmARxMyE1OEcbozZ5zHpoNSZJGjJZIe?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 707451af-ff2c-4b37-24df-08dc114d88e9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 19:59:48.8843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulv6+PTk+6Tol9idLvMnf4jgrNjZCx0QtGeGTc/wJO3Ha5CZeEvIq5VxZctlmiPwsn7dnFfXF5HkrtL77L9YLHNl8KVoq2qliHwCS/4Sp3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6972
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 8 Jan 2024 13:14:06 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > [..]
> > > One other wrinkle I'm working through is the control of CPER vs normal reporting.
> > > Current thought is we do what ACPI allows and start in firmware first, until the
> > > _OSC call.  If that requests native handling we go back to what we currently
> > > support (native only emulation).
> > > 
> > > However, there isn't a convenient way to mess with what Linux asks for which we'd
> > > want to make it easy to test the handling once the driver stack is up.
> > > 
> > > I'm not sure anyone would be keen on a pci_aer=no-ask,cxl-mem-error=no-ask type
> > > kernel boot parameter to instruct the kernel to never ask for control.  
> > 
> > I just expressed a similar lament to someone else asking about this, and
> > claimed that is up to the BIOS to say "no", not for Linux to skip
> > asking. It turns out that the Linux pci=noear knob predated _OSC:
> > 
> >    7ece14175376 PCI/AER: Remove aerdriver.forceload kernel parameter
> > 
> > ..., so there was legacy to carry forward. Otherwise, in a post _OSC
> > world it's the OS responsibility to ask and the firmware responsibility
> > to optionally say, "no".
> 
> PCI Firmware specification rev 3.3 Section 4.5.1.
> (right at the end of page 48)
> 
> "System firmware must only mask a Control Field bit to zero if it has explicit
> knowledge that the feature will not work properly under native operating system
> control, due to platform errata or other incompatibilities."

Feel like "other incompatibilities" is the catch-all gray area for
firmware to force firmware-first operation when that ensures
"compatibility" with some 3rd party expectation.

> 
> Meh, I guess I could add a 'native-aer=broken' parameter to the qemu boot -
> I'm sure that will sail through reviews :)

Kidding aside it still feels like a bunch of work to emulate a flow in
QEMU for a firmware no one is going to run outside of kernel development
testing.  I.e. the QEMU CXL emulation is for testing the Linux kernel
not the Tianocore implementation.
