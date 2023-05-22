Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55557C77B73
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 22:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjEVWuo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 18:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjEVWuE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 18:50:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A490119
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 15:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684795770; x=1716331770;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YOOxfPOC28wlu50XswNMgQrr+qnvs/9esjoZHw9nSRU=;
  b=WZR/hvxnESKgGyuMrpxHT5XoXpIEB2jrZOtZSITgtN/Jkqhiqb8+QMvt
   dEWaNpuF27svM4i7bFRyj+WqAvogJTZLhGaamA3ErSeKXiis0p+fve73B
   s716kiRZw/3O37QUL+MtIKwZjKI/7xBqsID81UI91hDUwfaV4W+wo72mL
   OAv94V85JtHVmSMcpWVcvbrnD3eVz4BDX2jsX6/d5Hw0GXzA+PJn+KKLN
   4+5x7p2HaDc3vRlg6wAvHok1SAld/1VM0ACO5Zp9ylhIpR5NFL3Quy+34
   9nKK3QHv/URCTyyN7A4hgxe9euZ9vGli6d9X+1IfDWDvu6Mc8v5ZLMz+v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="381305012"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="381305012"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 15:48:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="654113743"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="654113743"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 22 May 2023 15:48:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 15:48:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 15:48:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 15:48:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 15:48:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVvFFsOmOpEO0BZacaiN0m2ZE2SLMjHlODMWjkPGidGf/fZSxo5feNfR6IWeq8S4Pt3BGrVK2zRxkYD2aDgSZ/HbwR5sh7GcVykqrwclK8G/Sd54/tZp9EIXvQUB+I3vis2Hs3WFXRusrWadCpL9jZR+ELRbDNQIq2+wFBooyOA/O1ER+h6f6pgTA2a6B8Dkl4dSXaTZpFuRBtgoCPJgU6wwuMVaq6FoOH+5BRVBPFfZbCugr2RWNcR4AySChfMA4Qom8UN/xCcZGm0c/NZqGBPI8t9SQCeLpXthwdVaf+4l/18WAHVwQXKp4cqAjbETM7PM1oxAnWWOpt/Y6jhmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dB22PKTVw3JoFtlci7/DJyWOGqB23wIpKiAhlWHGSZ4=;
 b=nIUqwrpHAxlxhl9SvLvcPYOx7Gc+0kkUkwA+A+MjmoYUF0n+FGz4VaXkxn2Qv64eDuFBh23lJdus1Ke/mBiwQEnXIT8O9gvIRtUgHg6hfCoTo7EJthIMpdE6IqvB/GHJZJFswNLC8Cob+OU41233zkEn8lWN1rO49fkwffTp0JPT2rRQMkLFMdehsouKcWMCUtnASVzggFzEeswK77T4PsYr02Kxu8NUjITr2jE5NlR3i0D6WyruULptnJzH5dLSjQshC0bbvvBfpZr2WXUuxmGDQjcMLGlo0X3eodsOfLRP2NVOHy2FBHCzDNlFHf35cj2TjJcQuAuH1avme+03Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8262.namprd11.prod.outlook.com (2603:10b6:806:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 22:48:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 22:48:05 +0000
Date:   Mon, 22 May 2023 15:48:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <Jonathan.Cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/mbox: Add background cmd handling machinery
Message-ID: <646bf122b3c82_35a482941b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230502171841.21317-4-dave@stgolabs.net>
 <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
 <6468027e5d15b_682c12945b@dwillia2-xfh.jf.intel.com.notmuch>
 <64jusopypczmfmkeg5ulzw6gwbfv4mdnk2jilmja7iyr5dsukc@vkpwdjsjsbk5>
 <646bb221db164_33fb3294b3@dwillia2-xfh.jf.intel.com.notmuch>
 <ps5l5kclllyhjfaelf6p7cl4vsq6v3lp5uxoqt6u5m4ha7adw5@6q4gjq7hlxpp>
 <646bcda53c22c_33fb3294fa@dwillia2-xfh.jf.intel.com.notmuch>
 <dbz7qo7rsbyc7r4vtcwc5lkpzpy2uz3q3cfd7qekhghp3amn3x@264xhf4swkda>
 <646bdce675b59_35a4829434@dwillia2-xfh.jf.intel.com.notmuch>
 <ra4parotyzuzbqitq4qdenquqhsi4yesl5yobrd7kj6wtyzhuh@vxou7lguxo6u>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ra4parotyzuzbqitq4qdenquqhsi4yesl5yobrd7kj6wtyzhuh@vxou7lguxo6u>
X-ClientProxiedBy: SJ0PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:332::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: f00af2fa-911c-4d22-5672-08db5b169aee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rThe4yJDd7rHB9t1nOR9T0WqDw0Rn5tujUmzQyrBdwcWBwSwo9gXTKkLO8rHrtr38o0SNSSxy7ZqESktC8G8h4huuwCnVX3BstP/IoFrnxGhYZpUeZmZIlbDybrQEOnvGhkIUsfqfWCjtQTIUNlG9h21KKCRiuwUrWXWyP2ZAsJsreu0NYacWDXUXilEsja4iBJlT+LpR1gZovCQsQegB6EKYggQfejnU7fX/BOeKYWsAzPClOPqKojFo2lWha5aGitQLYoepGE96tdBd7U9FVJX97NHIpFjw0+8086/Cw6YrIPfQiLf3be/PHHaiL+IDYKjvSTjVFiZskuLe95prV7OEf/We0/naZrdH3T8CFA22+TiyajOrH4QQfsOKNvlj3A4wINrxjjOgCPlSoFua+ZgPqkgZaYGXimbD1VxttvwygcKWQNMRlYWGCDKbDJWqu8hhNBOBg/pfA2XEid9ftxbfwD52VuwEOcVsf1YutQAqi75lNF8+HQece0Zl3Qz5z6xtAGUnhi+K2xVICsdxIJ1t/t21DykNYMz0YpsLNYrldecy9An2OC1IwO6nc7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(38100700002)(8936002)(8676002)(5660300002)(82960400001)(9686003)(6512007)(6506007)(26005)(186003)(2906002)(4744005)(83380400001)(86362001)(110136005)(316002)(6666004)(66556008)(66476007)(4326008)(66946007)(478600001)(41300700001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OTyEvmEvEHqujmnS5iXmYC4/EDyzPjK+ORrrQsVdcAdZuh2QBr9ELAFXdI0S?=
 =?us-ascii?Q?Ijm+wHxldgYF1Gx5+j0o4Y2exsgB60pIcrHdT3LdP33oRARW8mbnMBArCIQM?=
 =?us-ascii?Q?erQhwaN8nVnDvmE7ey6TCknvDyyAWP7j9A+EB63lZGeAemo1i45szyyekH/o?=
 =?us-ascii?Q?ns73UXNEUvMYtY/CQddIqaydgKEWNstiVASJo1lCxx6aiNF9uo/6zv369l63?=
 =?us-ascii?Q?47bY8rGMpCMuJhvSSYXlp/xa62BoAewN/KZemb4Iiy7lrmU74MLZk/e2pYkL?=
 =?us-ascii?Q?NCMQTFO3puMJyvH0D1v7EdOfrE0mqYhm6tpaUkXwzohMRzkTpdiVke+FN7Vh?=
 =?us-ascii?Q?Y6dWnhj+f52vOAu5NX0WU7pmaI0D1B0+ZBo6ZsLdCzbpgim4tFmzOtejxoJv?=
 =?us-ascii?Q?CIss/MRDoOza8PiGbPOorxPI6AySxkfEqHQuSCID7hrQqGyXZuTodumL8RDd?=
 =?us-ascii?Q?YhCU14Rff0LhcmvRsQGZwgqQjG7JgFveznWPjCUqKVTVo7DWoziAjhSs+3JP?=
 =?us-ascii?Q?XslIXTSv1yA6Gsuouhnlj5bfIELIsoMfL4qi0xsa1oC/v03Uqbdg6366Vjdm?=
 =?us-ascii?Q?awjM1U+hv/3GnPdO0FmwYPvF14Fo7ZLzR9FI+FiddSlA6mu2kQchyHENtwHU?=
 =?us-ascii?Q?AX+4sr4yLwMtROxlfgUgFLmuO+ABXRKdB1octYmne/QOQpSt8TugQmqKGpks?=
 =?us-ascii?Q?FYIS2UFrBXxbrsScjIqJwLyBBcsxMWObLGFP3ZfZ8WRBjTheptpDKzpgaJyu?=
 =?us-ascii?Q?jKr5C+S5NP8EKVbVXb5FiHsXvAt36Bko7fgkSCo5mGyl/AuYZvg260j2CKuA?=
 =?us-ascii?Q?C9UHajgWWhUzckTwXdd3F8WMqdPzhofKg3SUEMjbz6kR9MpLs5bE2dls+LgH?=
 =?us-ascii?Q?kzzJz5DTp0KEnIV/1rhebosGEMqT3DAVq9TmynWkAJRa8jvfjmYxvmVqNYlT?=
 =?us-ascii?Q?vEvZJ6pnrH2rtn7SL1lZNft8aVlQNS78GjWmTOhX/8HAypzBzhQm5Z6FfgWe?=
 =?us-ascii?Q?B0l6irvxZRgaie8ig2wKCmHN+wp8Gu5nSWc489QJ0vapwIyhENuUDY5UZEUw?=
 =?us-ascii?Q?hDzQdzZujOj8o1aqofIkx563O3RTHONQDAfw348kamQzbSXme8r+J7aPQwNZ?=
 =?us-ascii?Q?WpxWqkcBOL00WwKlpBs2+itA+sJCf366/F+Bpls7uYICwdgW/IulVTgwUsg9?=
 =?us-ascii?Q?ytG9y8PFawnEsD9c8kzl+FiDZfd84vbuGJDmEbR6alcocH8norxU1mpSxIu1?=
 =?us-ascii?Q?XnhxR8XFPrmRCimnvN+lvqiguXiS5WJP2Nb+ABzvtn1fZSN2U4jiHA558FWI?=
 =?us-ascii?Q?MB2FxlSykvfzK+L75zqnpCRiuMDeUQWK8Pnpm90+1SHkGHN9d51dwxySGx8Y?=
 =?us-ascii?Q?hmNdf8dN49Fi8BLqRda3rR9Pbr7zsHAun2HJy370/pcbQF0C6IT56zjrhcOl?=
 =?us-ascii?Q?D4l3lePpXsiLQa2uXJbWTIJpZQy9yPGGNYbBZxghhxsMlL3V29Bwq7ZYYu8M?=
 =?us-ascii?Q?4kXCHa7+C1TdPfpOu6RpoU+NSf9JrZPbzl45rO6Lm/jX+mU4bGYQL52NELqr?=
 =?us-ascii?Q?l2PP+X2gpn1aVHcyO6bWCwt/djpF5mwCGxBOXC4CMo8Pip6x5vkHwk/7lwSU?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f00af2fa-911c-4d22-5672-08db5b169aee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 22:48:05.1395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RinOgQTVmm7JkXuC9QlsQTDRG84SOj8UPxmUSOQVDOmrTueviXW2zcCF6cCKVlFiMijDZ6omCvfhd+sRdQfy11cjeVvTI7WGrF7Ifuc0ito=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8262
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Mon, 22 May 2023, Dan Williams wrote:
> 
> >So the choices are either allow the background command wait to be
> >interruptible and then do an implied sync on the next submission, or
> >make it uninterruptible where timeouts are either a real device problem
> >or a driver issue that needs to reduce the size of the background
> >operation to fit the timeout.
> 
> I obviously vote for the uninterruptible option and treat timeouts as
> a rare occurrence. In my answers I was only mentioning timeout case
> because of that uninterruptible wait context. The amount of bg capable
> commands are limited, and would expect timeout parameters to be fairly
> well inspected(?).
> 
> So if ok with you a v3 would have these semantics.

Sounds good, we can always complicate later if need be.
