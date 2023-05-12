Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7381EC77B75
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 21:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbjELVjO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 17:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbjELVjN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 17:39:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD16114
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683927553; x=1715463553;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gSplC1pMjTwDmnaNKam7S3Vc4BhbKdTyESoi5xyprEM=;
  b=M4TH/mhbCnNLil7I2PPajA+oDpDT1P0JT7rPUJ5rUYMJY3+a1tM1NV9R
   Uu66hlOQpwfZY/b5Jbz8eFZvjNODPBKel+MTS2JxpXq1MKaAMpt7ai2OY
   AtVYaPDpu0Y93eNRq+ti1ysCK7CdP9NXcqLO8T0+wP4LCJcqMlHj2lvFe
   Mwfm4RhDMT8/celdCJQEG9fM8utI1TDfI1wxuR12t9Wg9Lk2liw6Fci9v
   XFfERcqbvz79XQQWELAcvqyUan/F54XqmojQJTz4+LPx3Y68dIqNUUamr
   xuN8sJZONaujmd6AIyuchm281kNELWc1pKUKjTodHAZdf6Fqe/EAnIxwF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="416529472"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="416529472"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 14:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="677809877"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="677809877"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 12 May 2023 14:39:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 14:39:12 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 14:39:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 12 May 2023 14:39:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 12 May 2023 14:39:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnDHbukVl7TIJChpOcSiZkqA4L7qlSzI34QghkOsglI4d3UoZREKpwsBf5crn5AYQbsKPnXw1dbiwiX1Or54lPpRsnsV7aJsbGLGpCeqKYAue5+Akn6uWb9i6iCPFOBPOEqN6lrt/pa/zQyx86d8aXfqvano4IbLT64C6ptL0q84wr8RCOXnHDOkd/JcjtrTWTIFWSsq9s58nbrOBNNzCnS6VBeKcL67tfyAo5ny+XM8JN7E9PFYWFnHq8xOcKAXhtGCbWHcbT9IEOCW6kTGjYPgM+jYCdVs838EmLytuOvkvB/+Tchtk4pcVAvQ4qZF91onGJtclsEqt4x8bAnWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEVtw14Lr6PDgpgHUCyCPPrm5vuQnOmqT7XTRA6jEZY=;
 b=UNGSnoojDeI6Gm7rG7v5ew9fBKTKDI/JyhEAc7pyXHvderMQSbHefAdJIlO9cAXZcQ6m+Fye1jDogPa4aSTBwy3osMHWRXPSu7yB96sj9vwXYpfHGB+R+7DOD7WrryCdSVNrPZDckbj48QWndxfC6LmGTdAYM4R8dnYlQFqTSzYdffG6Gt593vq6zwHrERC6YQ/EOD0w1E2JmZO8iDMFG7PvDN97LhEy4QFh3+sx4dqMfLuBMhjeMdVR3M38sdmHHKz3/wG+RNAzwyLR2B/8i+h0Xp+6JrcVkRhsx4NE80itoJ9LmU12gz8fpKoYrJ71Oi66VMAZkm3tpKmtTR+FAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5076.namprd11.prod.outlook.com (2603:10b6:303:90::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 21:39:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 21:39:04 +0000
Date:   Fri, 12 May 2023 14:39:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: RE: [PATCH v2 4/4] cxl: Add support for reading CXL switch CDAT table
Message-ID: <645eb1f6a395a_1e6f2941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
 <168382794705.3510737.14861252708548327842.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168382794705.3510737.14861252708548327842.stgit@djiang5-mobl3>
X-ClientProxiedBy: BY5PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:a03:180::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fdb1fd-70ca-44ad-a995-08db53314eee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0O2OHjFOy+xa3Z+9g0UoLwccMb6dDXHLWK01YgzGGd1SjtLfJ/EHbikYYKcu/rmsKOHJWtXQDzl4yBsjqCajS5GiFYXDjZIR2ez1R0Hn6xM3OTZfNuHa5YVEk4HsT8x4TktpNjtXWLc/FaxmeGl9yEtFZo4BoYHJdJiolqihZEEt52XrV/X4ZYkK5agN256q7TEEFtzSk+xhXuaI35aLiU2moHa64Ew25J/62EABXziiTw2lLIkLIXhgyYk+hCtENaqRZo/MWwv1i/oecDGn9/PQceDk357qAvXEeIF/MTI9eppVYkr8AmdN820Ge6iO79TpoKumIPYKNduz2i190TucEWdUsr5B2vcZduVOAsSqF05IV7EvlhRJDqwwkUm6aNO7nneIrE+HUQDoROXI1XIkT6WFl8oG5siIeZD7SYvP1AR4fU6pUBtDsegJSWsbUVbDf4sP8laVi25xpe5CvSH5EYYnprJIMrgy/Y6+em5CNjUoF+MMvTHNCPyARYI0I27JFMFfYOqm9jQAZQcequ8LW/KcDXM9xKynya25VecTImkNDJfXuU2/wR5XipU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(38100700002)(107886003)(54906003)(8676002)(66946007)(8936002)(66556008)(66476007)(4326008)(316002)(41300700001)(6506007)(6486002)(26005)(6512007)(186003)(478600001)(9686003)(86362001)(4744005)(82960400001)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9FP+g+XO/mWje1d/joXlNwkPQvEi123yJaDyYVHgg3CIcwKcY2J+W+wwKjRC?=
 =?us-ascii?Q?JRVArm6mwlqqRwkVg96Ag86pt+dtmWJDi3UGcBNf95Do7nqeiG8OQXCTcFnn?=
 =?us-ascii?Q?DXPvCAEMFZBKduOecpDVqIByzTXjPUyHal03ko9wTaUKWAo84f1m7B08I+Au?=
 =?us-ascii?Q?94wJfYWnY/qKbXGFYWxDBDVuDRL1XFTzUYSnZwZZaaW7ZRlh6tIzDD9Kmvrg?=
 =?us-ascii?Q?5hphQCePh5y833it/4qSv1kzp35R+eO1C4bUDyJZcCJnGCJlAzpxzn2vyGAh?=
 =?us-ascii?Q?R56kBydf+xT85tDHgslDXDymdxG/0ip2j1eVlfhd8VpZtz90h+7Fh1LfUGye?=
 =?us-ascii?Q?gmqqNr/KTjZRFlKZeK3/zRICLlOKCCHzEA9C1wVDuJrdBtDzeNfY40AkrReb?=
 =?us-ascii?Q?bhTrm8fZuKrNF8nzNKlTofVXW1rb0wMx5QfRnUPgJGi8M8BmO+DgcUvtVYgE?=
 =?us-ascii?Q?3xx9M4R2walyIaPll2KrUHQtqKj8c4ItI0fG3SAM9f3qY0Kyq3XFGUaZRfQz?=
 =?us-ascii?Q?3EdftSIuleqO9YP3tz2HFUIZVSQPdvGzpHaxdvNwh1SwtS1siPkJxfBmFsOZ?=
 =?us-ascii?Q?97LNwQ7lRxKHrWyNOvMoW3p9TqWLWZfkV9F4h7j/BfOq0GZt/8FVxvkYrrpe?=
 =?us-ascii?Q?UUj1g0e5RmE9c3GGTwYNhrVhFBeOXWv22PN2jQydDr2EFQcOYsBzyc+KJNcb?=
 =?us-ascii?Q?3STxXnQjOJa1BGyobjk5eVZ2lsJVFoE+YvqxQZ16U8zTnCyUgEf/fVaFzOgz?=
 =?us-ascii?Q?Z562lLbvYEXU5pO7V0RnNmP3Qyb6enWA9VZCS5FEM6eznUCD9LKrqYHdkl0y?=
 =?us-ascii?Q?h0v12xSCxQ82Cr4tL6E1+UvPra8XBSQnw5Fx1xvSOmNnIylwie0uXkLZkxiq?=
 =?us-ascii?Q?wME5TC4k/npQOvnVElzmnU5lf1IY+RjaZlv8J0tR8qbimdwo5TXWKp0C94kc?=
 =?us-ascii?Q?QA7VZ6zc0iH8V5EkW3xTVqXyXpSBWaK4GA7F2Oy5Ff/6AHwvu3G8RMQE0jh6?=
 =?us-ascii?Q?Bnxc/f3eYG/Ulc/2wKucMXN2pGfrp6jqbWKYyGNH2N/I3Hd3pMcerJ9a1TWG?=
 =?us-ascii?Q?EgIMTbT2Xd8uNtLe3uT67lJIOEW4K7XdPMRaq+uExjm23upR1J7ehQpgX538?=
 =?us-ascii?Q?PuWo7dboVgbiQsuD9m5fj7nYhrCcwJFRT+LG/cwKSFCn04BrpVvI++kX2vmr?=
 =?us-ascii?Q?5m0dyRl4zx1yURQNyOJMChC261yGlNVVhOAKwnTNaH79WJfOiU7qrToM25fN?=
 =?us-ascii?Q?776EKQUMQOgRzeLlmDlec+Q3ovHSBrcFj7qFpaK7Vy/f6aQB/AAgYrkaCJSK?=
 =?us-ascii?Q?+wsQpgYN1UOPYp31bGm792NI1Yt5lYNp6rqMViHhDwZPLVyx9PL3fI/EURrS?=
 =?us-ascii?Q?SLS1P3gBzmAivPx4AGNEjSqsYMKrFR2h8bObWBvny9Cyf11/G5jzrCxolEni?=
 =?us-ascii?Q?VYYbyhRajuQrUWMzzPbV/r+8JUp6awzG0cr/IWRAHYsHI9XQxBttkqmsUK7h?=
 =?us-ascii?Q?LpH2dHZLsXttWIb1wUfqCujrzhqiU3BdzXCovEMbjAAMru4M1Et2RsxLfhsA?=
 =?us-ascii?Q?Cm70z1sl3tA9iOGtrZghzIDTICFHv5UIHHYy7TDMvHM6rr+aZc/teJ8VCs+8?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fdb1fd-70ca-44ad-a995-08db53314eee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 21:39:04.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EhaHSZICZMEcKddIZQ03GasF8n06SQjr/36h+/Z8a3HB06LDwCzT191EtsZ5AmITkxmgpWjHj0bjSIFuNnL3skl38tFfip6exQkm9EcBmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5076
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Add read_cdat_data() call in cxl_switch_port_probe() to allow
> reading of CDAT data for CXL switches. read_cdat_data() needs
> to be adjusted for the retrieving of the PCIe device depending
> on if the passed in port is endpoint or switch.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Looks good.
