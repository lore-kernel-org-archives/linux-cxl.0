Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9633C45F46
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elj931EJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587559D
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 15:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696890773; x=1728426773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=E3Y3zB6fyC2QFJZJfHCpKCpaEZ9SfoiBGsnxTv9hUrQ=;
  b=elj931EJIhw4Yjc5TPxHxOdzbw3OFMXq8gFOtlXXCmT+kp35Mto70dIA
   wdFaE1DMHlX6eR9bAW5szt82WRndkmktth8pU61mFEIatNqs8yqgELkS+
   wJvsDQOl/HaU6hKPXYW7njsnP4BjZQswLVF89oAo5p/VH1uCjr2MpZ7gv
   tk/sN1zbB6NPcZlOPozTnUIWAUOuadFcVrziiXYoVyEp7NpLIQSapedGO
   SmqJslyK7yc/hzt9AchNuElyJmcwxqslK5YPD54pJMwqzjYOYVKtXoPpW
   iMqAfeozRorYZn3XSkeAuD9+QqAc5gAQxcDu130CylFQOHR5FFOE5fQ+5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="470521821"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="470521821"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 15:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="926898702"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="926898702"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 15:32:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 15:32:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 15:32:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 15:32:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 15:32:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVWG8lNOp2BVnmqeFN5CNp+HasDQkj8Xvxb1Ca7kCXjsll+yoZRYNGJSzPGQtnXJV28YbNTB4T1gHcwmLObqwa9fk1jaZwTSvFewD52KQdXkjp6DVXBwZ/pwBLX2osTto3TcpOg+EOVRWblnvM96WSSdTOqw150J/1bvyMQeQzTAdJltqKZHU6WGdSBUSPRqmwmUYVcHR/gM5hiPgHx0d9yoajCHSkFsMe/bAEBVQHhoRTv2RlUDfN5TJTK63qPfLZT1r/aO5NtGb6WUH2Yu3ahSmx5OYXdV/dNlLbqKQDqG2rhgoqo5dt4oyDC/OQT8L4rbwoLFRGUNrPJfcTpG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+oduT7OxY+QefmV4On5wvUwrd/RbHYqB9QtK+5BYGE=;
 b=NrcKuxGqo8Gl2YfwATSby3uTA0l0TAXbntLfBjgVCSgFmIBmcZo78fxirFwXwONSKVNwhmmlJNXmvVj73EWD1lkzBFFPfmyqiQ0F0l1QyJIJGUbp1KESJXWVIdxrFOGJouiUvyvVy+o7s9AhAIdDdOMwRhxGdlDV8F96CiXL1DjL3YtWDcRCZmHhbVrs0M7dFlUSDhqFigcM2Bf/56IVB3Qh8fxb7D+8tECVJ1k1JjqzhCwPkRF3K6hRAIC8DYjMO+3aYBNPkARtDUXW5OBZ6WdbG1X6FQ8kR+pPBGY2Z22u0tZLvfw3sj1ao82KpMn7zThAlV3hGhGCMb6y+wllug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5064.namprd11.prod.outlook.com (2603:10b6:510:3b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 22:32:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 22:32:45 +0000
Date: Mon, 9 Oct 2023 15:32:42 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3 07/10] cxl/memdev: Fix sanitize vs decoder setup
 locking
Message-ID: <65247f8aa6890_1a0a29467@dwillia2-xfh.jf.intel.com.notmuch>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657719974.1491153.15276451196916291864.stgit@dwillia2-xfh.jf.intel.com>
 <65237eded9811_1d988429470@iweiny-mobl.notmuch>
 <652444042bd98_ae7e7294ad@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <652444042bd98_ae7e7294ad@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:303:8c::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cf1ce5-2ca3-48d0-9471-08dbc917a85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ux4dhPzSSbOUzBhlbZf+dJlvPg/L7iN6oIxEg7rJubb/qC0NLsnZVOJmNV3HgHjGO1iPpAGESd5nwN+eI/C+zp0T+EDuLifEVxWCdTY62g9vPPt8lI9cjhHKyTykzLM/GbzdF4sRAmwq82jIlClfIOCfnlthSfqTDe94ojKk8nhyMWfEaqUch0dSy9RvzzoJUWb+dvR+kxXWgAC19Qr0ILN0Ni5lM9HeGhTfATacN5g+DCh1MkiOUES5SEGL+K4Qz+7q6sP7sWTjOoIyn7B7rQcjimWQKlJGps6J6dFz1TLby+XQDkQIvmqYNR7x0q4F+KJhHg+IBAje1pwrc1HZyaMbKPAeiUr2ADnU4G4jLEeCPbYnbGHqvryBw9w7Eap/ZWW2rpB6h8C1MA5RjDtOzMOGW4EWLqCbaKSfS43GuebU233uM+eR73dsL8ZtH1uKx3yL9r33oRz7GEpFWI+tBCMxPVLYwhIzPSiNomZ8htxIErPl6oi51u7sVCRMWveaqNhaRD7H94XBJ3UWV1TklPz9vqnpvRkQRqMINhnNIQQY9rSDOaexjQPcT8ioASrM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6512007)(9686003)(6506007)(8676002)(6486002)(4326008)(478600001)(6666004)(2906002)(83380400001)(110136005)(66946007)(66556008)(8936002)(316002)(66476007)(41300700001)(5660300002)(86362001)(82960400001)(38100700002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I+fOcVo8hHg2YuXqC1AIFTqIzPykE3c+nZavfQfyela4YLCI4p4RDKuDWVpp?=
 =?us-ascii?Q?rwoDPQ7Ih1YZj/S5sRoZtqLk+fE6qmQtRzAgp5HGqdGCPnn0sUKHZFBG2Gmc?=
 =?us-ascii?Q?L4eu8m6jljLlExJvvZHeStJ6teUXFj/8guLPWgu547/eEQjxSugHgGZQlLsL?=
 =?us-ascii?Q?kGoD0ao1v9TVTCH0Qs3QLmaCiJ7E8+D9NskheLStpF+bm0Rr+Ml1rZigRSKz?=
 =?us-ascii?Q?qWC7eHXO2kB0BUXZooH5uSrS4N1q0bWTmrQyIj+x48Kj2Hfb+BuMilZXEgAL?=
 =?us-ascii?Q?v0CVJj041QqWCX7Trtw534ViqunEjD7r+KqHCocxOThylFJoOqvMLqBfoOgo?=
 =?us-ascii?Q?L/vWDOVZgbXX/xaaqbbq/tf2zpx2tcnQQVDPdfn90zKmVybgTJ+af1g+zKjr?=
 =?us-ascii?Q?HNtm5QU395BedqQbh35Z+J0dndRBFJNEMW0ZINLYGOzVDJLQ4YieV2tksXVe?=
 =?us-ascii?Q?2GhD6UMj3L1IONHtbGHK9EtMq6ULCGIpCr2DSaMQskZ66osao7NzrZGs2QCh?=
 =?us-ascii?Q?UCMpV+mz+NdzpxJtgXZCKT31xA1kFZ0WiZXMdEZOmnDJGj5qT2nQahzE6bQ7?=
 =?us-ascii?Q?A7j0LMyMN6e83eG9w0iYu9jOMOrrhRLlaWU/Y9mdZGpI6KCuJnpBTZ/5PnQG?=
 =?us-ascii?Q?/Ptv+V3MXAKwaZI+xauz5P7nQdrwkZoiUvuJxJKFf0U7xyKSQW/kYPFRjrUD?=
 =?us-ascii?Q?gUWGqrSWga4oqEu2AkfTwIpySrmiwildQvHIZWkCL42e0BTqAwB2AuV2Y2Gn?=
 =?us-ascii?Q?Onzju9NJYOgmQ60E8+ITEKnA560aQAwEVFMvMOJN129xNi/1VxGV7Zlhxny9?=
 =?us-ascii?Q?UXwmmqSOO5WXUhU0p5JR6TiwBB8CD+poXDmDp5doPhoYki+lLaIcoAJUV+wY?=
 =?us-ascii?Q?sBS/omU0UFflXSHkSp4hrNHMljCNdT//mA/SMkZNuyoGPRFhGrh8g1kNaNFI?=
 =?us-ascii?Q?1ZfiUyyPdwtxCTbnDNpwIPqskXuzouqK90cUEwNixy48qnp6u/dTtOgOAM7v?=
 =?us-ascii?Q?sWVDRKG5K8Fu9mHuLvKsKhDvic8sNda8XBWw4CjnH9CSM+qlhfJaJMxpKgW1?=
 =?us-ascii?Q?iDRG8WWjng+dhUztOo9jufH8yMFcZkFsSfNaXF/VZWJAMT3iNqG2qKUmpMUe?=
 =?us-ascii?Q?yTU/GH8blOYezQFdxeup41FHjEN15US9JvdXUey29OpOl/wiIZa7li5UiMXx?=
 =?us-ascii?Q?27dzCMxlsvRL6vJrfP4+jEM7akP+awztjh5PL1z37r2MLv7DXcdHdvc0u5Ld?=
 =?us-ascii?Q?oOagdLeUKsHTBrZbWqL1iF9uPu3FXvT5ps8nIwA7wHwBmYWpqKgJFq96qq7i?=
 =?us-ascii?Q?TgdK8nth2th4ooWYwkvyHfmvQDwAt4I6walNJe1FJ49XCW6WxHIXo4OHOmWp?=
 =?us-ascii?Q?JjCWnIzuySGQkipEh9yUnhePQiflBcwer3lONAiGL1N7NcUyyLC1T8AfpLA7?=
 =?us-ascii?Q?+u4QmL82/PtHjypv43DUU1KrdKW+DyNanVZ9OJ6RJwxucogIB4gw2qQJtVUV?=
 =?us-ascii?Q?AV2uwsJRdDoTiCT6FBhiTOXC14Ajxw+mBiSHwYKXpHYEBJJKvA5T1YtGSgHn?=
 =?us-ascii?Q?mYb4Ky3TyRj6oraxCgoqrck9sb4ri5u92GDmbqpAQjoNaHmE3TbKakIx+aRl?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cf1ce5-2ca3-48d0-9471-08dbc917a85d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 22:32:45.1090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfmsx/YRLUi1SlagUUUbuXWg/DuMTw4rWUlPvNegMynxPf/ca/jqxUt6GSpZUDn57vqWESHtl00HYa+tnXh+IkBTeQZUGHBOk//GvKaNsAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5064
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dan Williams wrote:
> Ira Weiny wrote:
> > Dan Williams wrote:
> > > The sanitize operation is destructive and the expectation is that the
> > > device is unmapped while in progress. The current implementation does a
> > > lockless check for decoders being active, but then does nothing to
> > > prevent decoders from racing to be committed. Introduce state tracking
> > > to resolve this race.
> > > 
> > > This incidentally cleans up unpriveleged userspace from triggering mmio
> > > read cycles by spinning on reading the 'securiry/state' attribute. Which
> > > at a minimum is a waste since the kernel state machine can cache the
> > > completion result.
> > > 
> > > Lastly cxl_mem_sanitize() was mistakenly marked EXPORT_SYMBOL() in the
> > > original implementation, but an export was never required.
> > > 
> > > Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
> > > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > 
> > [snip]
> > 
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -650,6 +650,25 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
> > >  		return -EBUSY;
> > >  	}
> > >  
> > > +	/*
> > > +	 * For endpoint decoders hosted on CXL memory devices that
> > > +	 * support the sanitize operation, make sure sanitize is not in-flight.
> > > +	 */
> > > +	if (is_endpoint_decoder(&cxld->dev)) {
> > > +		struct cxl_endpoint_decoder *cxled =
> > > +			to_cxl_endpoint_decoder(&cxld->dev);
> > > +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > > +		struct cxl_memdev_state *mds =
> > > +			to_cxl_memdev_state(cxlmd->cxlds);
> > > +
> > > +		if (mds && mds->security.sanitize_active) {
> > 
> > I'm curious why this check does not need to hold the mds->mbox_mutex?  Or
> > how this may be protected by the cxl_dpa_rwsem?
> 
> ...because cxl_decoder_commit() knows it is holding the cxl_dpa_rwsem for

s/cxl_dpa_rwsem/cxl_region_rwsem/

> write which means that sanitize_active can not transition from false to
> true in cxl_mem_sanitize().
> 
> It does mean that in-flight completions may race, but that's a benign race
> where whatever triggered cxl_decoder_commit() is already in the position of
> needing to wait for cxl_mbox_sanitize_work() to fire.


