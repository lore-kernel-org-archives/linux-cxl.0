Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7m7LH1G"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BFED54
	for <linux-cxl@vger.kernel.org>; Wed, 29 Nov 2023 17:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701306093; x=1732842093;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IDVpBkbjKtUhUu4y7yjdz2Izi1npfkWk2Xz5/U9gHYU=;
  b=I7m7LH1Glri8gIuHULxnvpLoa/jBAg107lhBrcWWtXgQOFXB9V6EPDJS
   vKhEC/KfbrHTIw9qLk0HtDGd9pFdPU7XxpWxn/YZkjW62QnlsvdK2PNVu
   XJXQLDfSBfRFjhIwbMEPAvLiRP6HwwWcXkdDOPrBfgSd3l0sMR+TgYSSJ
   vdb7gt9Bw2ZcdSJgez09lQySpEL5QQD42MH9Rz5gaj4QP6O6lLe3Z4iZd
   mJAlODvBihkMRzLJDb/j0xUIpaMdAHPFoHb4LxX65JVd/XX85OhJl7mDn
   qHicCFwdhpgAho6U9Ovha8p+uRDij8Zt2gbCF/Dpd2BUONBth6pJafx+D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="390407741"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="390407741"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 17:01:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="772878001"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="772878001"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 17:01:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 17:01:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 17:01:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 17:01:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMR4FiDYk2uIlz4LZkl5zf4DSr924A58GGkpq0RUgL9ItLqNg4Ecxm32ISpz+Ald7U4gPfmBj/jxtMf8GgBgGDn+L7S7IPvrpIfwXRrAY094MajFNa/ZAdhQ22k+XGIZwYAkXYElqrdZIiUMrjE8NzVvPFgoc4WQiZIpBF8/fORL//m8uoB8BurLidx62sf63oCwZ0GTrd9WCUsk2G7ygdFewZZ5Y37vcIJS1UmXFk3AW7UaEsl4eLmzuek/TgduQ9ZG6zWkO2dEm31pTcSsqPG/RavVBjDgIZOqPldU0oZBBQyQ0HlrW4UZlhietGgU0A5vlMekpb2bnJg9MmlKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYI4mFs4h2xNbvTIM7Tp5ClW0Lg9EMNiY85D4to5mAU=;
 b=JGLSoAo+7GrTY0z/iVfP7XnL3GvPPMdtHP5jBNctXfzVYHlnS1+49xYP1aSs5DnF3uUwJFBGDR6Sq8R6qiF0D+/wH3zzCcdoRBlfBvhVv3cVIHDqBrcai9J8nQNmm3MrCjaJrihkz79wU3tZIwK4ZnenVv365lPhRdQ0hBkT+4U3xrGbX+3Hy9rpQN8u/Yu/Eu1crxs+bP7aum0GkMJM9LNgYx6FUZjcnNzdoSbCs10r70k6zZwxJgEHisg/bUEOuFt6NEjQO/8pMz2C1oluvySG8yiCv7BUCY6hIax+ye2+m9Cq5XPNZsmvDmjeDTeCrbh8XRCUuHjbV1tO1NCddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7790.namprd11.prod.outlook.com (2603:10b6:208:403::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Thu, 30 Nov
 2023 01:01:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 01:01:30 +0000
Date: Wed, 29 Nov 2023 17:01:27 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<peterz@infradead.org>
Subject: Re: [PATCH v3] cxl: Add cxl_region_rwsem around commit_end write
 during decoder enumeration
Message-ID: <6567dee739164_c3ae2941c@dwillia2-xfh.jf.intel.com.notmuch>
References: <170025232811.2147250.16376901801315194121.stgit@djiang5-mobl3>
 <jhsumngltwjkwpa2o2ktxwjujmuzdzrza2m4fyd44ieva3l2ca@trrhklq6evtg>
 <655e75e929fc0_b2e829478@dwillia2-xfh.jf.intel.com.notmuch>
 <655ea49a7ce96_b2e8294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <20231127173936.jyinrw7a4dtw7los@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231127173936.jyinrw7a4dtw7los@offworld>
X-ClientProxiedBy: MW4PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:303:b7::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f59e50f-c70c-417b-bbb7-08dbf13fe2ed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BOmDgyuoIF10IW3hR4sRTrmKLKz6eFW7dyqjuVXaQBaXmW4QGo/5iaEm4Q5d+Z42tKIRyp/8D1dm6C1hBy6CVxjZ92PcbKBtnuhpFXugRd9PqiN67HqGzZI/3yzVvFJoVDSY52rPbVJaXPZLLVMTE/3W9hVpHyTSC0oR48788rLZ32haG9Nt8ZtoRITkB8020S3TVtZSOwFEgtvu9lBohwElqAooLMBM4ytRzZBgwXpAJwQ0uAx8aGOPgfofscAXz8JkM1BQmJDg1AyqoGDPzVTJohLiKoWbCNjYJr/hjfuV4nudJ2WPZ6J8JSoi6ZZ1OugquSXJZ3RQz1GE/38CAN211wS1GNFSrZxgzfXqgZ0bsye8QaYGqHZ5L0EHCU8+BUab4LY3w9D6jf+FPUUDWzW9ym0V9Ri968baibkwB8Jc1LCqAPNuxNwxd1xRhsV9PcEwMwKZN9/X25PWaarCVNhbHpXoPoisxBI/h+wHRuWumI0A8/Vri7V99jToD+0simzW5YYn2iWoKbtdO+4j22k1HL5l/JwVipH4pPUAJO2W5J4VNQi1AZlW3wTbQG/yToBBQn/VdEAf2KCZDCg42IYmPJzUyw2ky/BC835t8lwEAbe0VX7gEEZM+c4qmdo/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(4326008)(8936002)(6666004)(8676002)(6512007)(9686003)(6506007)(66946007)(66556008)(110136005)(66476007)(316002)(966005)(6486002)(478600001)(202311291699003)(86362001)(38100700002)(41300700001)(26005)(2906002)(5660300002)(83380400001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?daZaHhpLLuLyFk37bv4TqebZi2Mxjfimf77YPWFr6ngJdx1DhKMXYi1tBVyf?=
 =?us-ascii?Q?qsSbfn50tuxXPuGNTa7Gnn3Th+CFy9kmuiZkISwGXaOm43KYcd5t310q3jm9?=
 =?us-ascii?Q?P3lm/q6gtwyPj3ZiXTGX/iRbfnhdfqdjTYT3S52tkoKTp8Uj7BeCK+orirBd?=
 =?us-ascii?Q?TgMOy0W4wwfekoyc47SBTPWpKUFJPS3m8/4tlr3M7lj8whEoU0oGh4iklujC?=
 =?us-ascii?Q?InBxeP/Ens6CRMF9FRXRCSAz5iTRFLk2y03CoJkMBNOMV9PvEx2MdWTuxKLn?=
 =?us-ascii?Q?GI2viOPXcJSKSBBfo+NmFTzLPCYSaas31jaVH8L6Nh9X/8KDwJY+veX/yEcI?=
 =?us-ascii?Q?J7oaEd1RUGkKi+TRg7k8NH2UXO1zimUQtZ6arTA4bTeGZk/1+sT6UgetLOHM?=
 =?us-ascii?Q?RR0q/IR4G+noxUgMNdfEkXHjnLoKXi9qo2jIFqOfhIvBxCVyD7UL/fnP5vcs?=
 =?us-ascii?Q?RP3f2IqS3mFfvP+bFRXObzaZmncdz7rmeq0tHmTS3IP7ghHyXMP3FuJA4TiK?=
 =?us-ascii?Q?8wyRUHHsfXIjCavcGSBYNpDbmptVlBbBovyldG0UT2UhlrVJ3j9YvN9qQ4+C?=
 =?us-ascii?Q?aniJepzu9pa6QEunV9rJmng6hxh4RWpVNAYW6tdq9lOla/wgdHf2KdafoYHv?=
 =?us-ascii?Q?/jxpOYSVxmpK/qpQvuW/pT54dIE1aRl+3xsRkJJD5ERjAkHy7awuuS8cNglk?=
 =?us-ascii?Q?/n9gLns1HsOk9tRQA/XdgNOqjAVBa1ULNKs+E1GTmykPKcCKI+w6Dt32qrzz?=
 =?us-ascii?Q?KnDEJ1Pf0wUg/SjFYN1Vet6TTgs7OXc+T6B+KfHX+IkW+Tzy8gRcbdEQtKLo?=
 =?us-ascii?Q?DAZUuYD3SR2sKvXqXFp+OSGt5aiI4EtL1QZ6/Bg2hWq131U+S0QU3rejEsbG?=
 =?us-ascii?Q?0Zkbw4E25xwb0Uyls+/iymkG97nHQN3pBCh48NdgPHGbmrUjG/oZlw/+0kmK?=
 =?us-ascii?Q?3IivI8oJ4Y5Mwpu776kfWgUkdbQMrryzkL6pBcgbJEnElqEa+/h5QjjheC+2?=
 =?us-ascii?Q?q1g4ypKgf3tuA4phJnxlBo36VeUYYNep75XiYbsjVSAvQa4LA3lrFGVYO26I?=
 =?us-ascii?Q?wfI74GbFEgAxkmrzxZ9sF6N57dIAySsOkPg79dbaYMgY0uOLJFYXABfm7ZtH?=
 =?us-ascii?Q?WZb+ayRsAc2DZTZRmsHUaWggBTN/xkC+698xzGiQx+GQl4YUXPAOYLTVtbO4?=
 =?us-ascii?Q?PbCuUfNlgcKl7TqWcdPeI6XcYjerBHw6unW0IIdF7HuOTMBKQV+ItX219Bt1?=
 =?us-ascii?Q?Y8Kgaw9AUI+n9voKwHkPMmyfS5o1P6fL02A4X08gQCBomh/oHi+abTfApRlx?=
 =?us-ascii?Q?ot9CzhW9Y8ANzwBb3dfgS+txeYAX6IuGP4E0SIVDU9fYUN2hdGmLlGbjpm8s?=
 =?us-ascii?Q?IXnp3w+WFvxa5GMcF++Sx4gntoQhg4CcufrRNRYM7NLQrsHKGSNoHdcPg068?=
 =?us-ascii?Q?W7HUfJ8arRhNqBTrJpciZGEls4of9CNqcF7ITDm0YMWks7Pv3fh56dctyu35?=
 =?us-ascii?Q?Ed9t/A/9GD0alZnoUO/numnqFtr+MlSkLCLJgDc1wDbphS6QfPxFU/d8xx+1?=
 =?us-ascii?Q?aDCX4Cpp2CvqJjFaDnBgZZmBNGv1yLZ1Ax+MM/13o6n+PZpCnvraQmNNuNPT?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f59e50f-c70c-417b-bbb7-08dbf13fe2ed
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:01:29.6769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JLFnHJtD3S7pqq3IlFJgp9aPd/7vQCr9Tj1pjnzIbYyvDvZ4SlTLmjkezlJJ6Tci5HPd643FzA7lL7LmATDliKEi0g8Vd2tHP6dpjmCecQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7790
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> On Wed, 22 Nov 2023, Dan Williams wrote:
> 
> >Dan Williams wrote:
> >> Davidlohr Bueso wrote:
> >> > On Fri, 17 Nov 2023, Dave Jiang wrote:
> >> >
> >> > >init_hdm_decoder() modifies port->commit_end without taking the
> >> > >cxl_region_rwsem. An assert splat emitted by cxl_num_decoders_committed().
> >> > >However looking at the code, it looks like the write version of the rwsem
> >> > >needs to be taken due to the modification of commit_end. Wrap the write
> >> > >version of the rwsem around reading and writing of commit_end.
> >> > >
> >> > >Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> >> > >Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> >
> >> > Uhmm but do we expect concurrency during the switch/port probing phase?
> >>
> >> I answered that that detail here in response to Fan:
> >>
> >> http://lore.kernel.org/r/654eb8ed72ced_46f0294c@dwillia2-mobl3.amr.corp.intel.com.notmuch
> >>
> >> The takeaway is:
> >>
> >> "I am in favor of adding the locking rather than depend on a subtle
> >> side-effect of how CXL operates, and to avoid adding an unlocked version
> >> of cxl_num_decoders_committed()"
> >>
> >> I will add a note to the changelog to that effect, and drop Fixes: since
> >> the lock is not strictly required for correctness in this path.
> >
> >I rewrote the changelog to this:
> 
> Thanks, this clarified my doubt.

Converted this ^^^ into an "Acked-by: Davidlohr Bueso
<dave@stgolabs.net>" if that's alright.
