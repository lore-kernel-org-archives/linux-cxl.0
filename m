Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E8CEB64D9
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 02:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjFPC5O (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 22:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFPC5O (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 22:57:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AEB2953
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 19:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686884233; x=1718420233;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hbbo9+GPsXe5+WHWdXsIbUMubkvNGoZn7j/bkptTeQU=;
  b=IgX5ilXxWVneh3+u7bzk1MGN97LiBFs3X4PRWxvNreGuWDuo9dbaASAy
   fWSqpB2rISr9pqmGCHm8IOe2QLbPGEsl1EjzZHw4Oo31w6lwUlgOxS+M/
   XvxiH8VmqI8pvHqeDoibzd2tCnPM4Gdx7ChL5Y+VWmuK+VPcIwei9tSvr
   N65iD3OhU8TAFdQgu+i63OhnkYZJBWxAW8zOHY/6gG8tYwFbG4G3YAq4b
   LHSYbqV8aZ3XIKAApA+5lAF9606uCHb0f50k1P9N8o474Cd11gNey0/LK
   CpXlo2m1UYia2WCaRrxA0ZBrDvzlb4dQVPNjPY5UMOqUNYrG+nX+ZrwEB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361619985"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="361619985"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 19:57:12 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745959694"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="745959694"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 19:57:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 19:57:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 19:57:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 19:57:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCqiUUyun9QPYz21+USvuR0aIfAhOGM/PtH4J8tytjEh3tgqQEMZbSRUN3zGC51JD0hEoN/xwJFwnbnqGN0873Spne+piIQHeS2kQOhFd+MIjBRZo51WIffqHPk/XsW8RTxQjfvc+wUr5F5w9tz8nayPqT5HUH6/wvY6pGLmG7JGHDGDH1dLTBsIx0EOYr5CQlZ90sXU1zbdfXNdLVsUTXTzWLTQj/H3SXtI5E61+p9Dya0duPJeetLNiA6QzXxs03alQ6peAiVHmAREehXP12U+PjdKMcwVurcSgk1MjO+V2THNr1ehlI5z4WaMKeGadHkdaAYFEtw+RXhdJdjzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMIq8//2+L9BKOrN4P8GFaau3QTfB/v7G7Z0GkBkUO4=;
 b=YrKTar3KSnJ2S2u4f0A2+p40yC46T8t6+ev5MD7pa9smvAg+naW7+CETdSqIAchG0jNhKzzieqdXjgZpfbQZ1INVrXpK+opoIkBf6CbYEtgguCNGYqSR5ChsMRGgsKUKwoVowOE7duI/c5R9uMzQkW7R5zjPaYJ4Ihv2mMepM7lcuEmBhGxkJON9i9sr5u2Hl3ZtMX5e0ShbSrxa3gNjBo2gJTR4FAjLq0mpyzSB7TBrxchc+ZyaaOFjSJk8UnaSGsiUaRa4nuREDPd8lw05ciyibbxL5bH3j/1Z9C6MZ02qRGL6/WQRk9p2rAWd57bzGo5/irMMO4nXqjttdI6bUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6540.namprd11.prod.outlook.com (2603:10b6:208:3a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.40; Fri, 16 Jun
 2023 02:57:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 02:57:09 +0000
Date:   Thu, 15 Jun 2023 19:57:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 0/5] cxl/dcd: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <648bcf812e1be_1c7ab42948c@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <ZIphuWVHQ8rrO28L@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZIphuWVHQ8rrO28L@aschofie-mobl2>
X-ClientProxiedBy: BYAPR08CA0070.namprd08.prod.outlook.com
 (2603:10b6:a03:117::47) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: a78ef019-1c4b-438f-4241-08db6e15604b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+T3shG3E2ZLq8UZvfKKB1tazdXjnDRYeC4GZd+l80Y2ETWWRx7dxW95IZELr0SBlTIaSARDbI5jh1bX5kPmMiZgrJbAUSAXbztpPoKMzF4t2pEarvYG5VEZCLm5xxljgeH3X6tE3g2F4poOB9kdm3/mqbguw37G10UAcKYZC5xotqrdw4LkGqHCUAmuEZ2mruSmhxu6BthwFEHuPaM8wtjrxb1XYCPwlletZPQuPZjfDgot2dUA7m1cRpIjbpJPpqqUyrZ9sbcoS4vxZpapXrLX5gr4DFagqyMtYqMz5ygfZOH+Buj5e+X1LqKUIgcR+F+moInT8p3L2Rbwogy6bRSSfS2lvR3UAkO+eG2D0+GNr0FM8r3JTSzZzsrhGlDfW0JD2JeD6oNzoYYEJK22UU3a2ZgHVPvZWBtwdLD9OSGRGqYNmnAORcxPkOsHzOGiGoLbZCaMaKeBWTnu3OWTSs6AkhQz+4rlYWaf5lBipJtpibadc04IlPjGt/lDF9vAsfYDDSRz8yujg0qsuuSTPXQd+Givr0icplkP3t8FjqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(966005)(38100700002)(6506007)(26005)(9686003)(6512007)(8676002)(2906002)(4744005)(44832011)(5660300002)(86362001)(8936002)(186003)(6486002)(6666004)(54906003)(66476007)(4326008)(66556008)(82960400001)(316002)(41300700001)(478600001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EAmfIkQvnIugWrAIoyyRET79UIjSN3ATA0hLg7U7wyQg/Asb5+OGK14ranqj?=
 =?us-ascii?Q?pzUNS2GRit+mZMmrJFN1NU+M8kk0jawLlFl1lc7tCAJgxamjtUKWcenaTMXP?=
 =?us-ascii?Q?BzJ1ctSWhyyF9j926Q1dvzhWwKhTWNN+hHCRxe8bTUBcZIQ/6EwOd5yYrbPw?=
 =?us-ascii?Q?ayZfsfy3fAyuRffLRMm5oEHZwFMTtuEGN6N/JzAdtiBZF/U2gqqAs+VY4JBS?=
 =?us-ascii?Q?v57/43NRzUPhypo02HSaeuTNCz1Y+jNl1WAyxYIqJ2EZ9O2QYCEOGAT7ytq8?=
 =?us-ascii?Q?O5D0z+yOBaGb0aEq+cet2ijsQ5P5xLN1sfW7im6xt4jgLk6wakY314AFcoHp?=
 =?us-ascii?Q?NNVRct0cJwMk5Z5JWAcOs6Rixu1X5L+LQydgNO2OFvcYl/7JbNnmu5TRl5LY?=
 =?us-ascii?Q?oxJF3AEKoT9H/ndGiUAG3Wwb9735vJBtx+rLLMjV/fG1Efyw0kMTIUDhNIoz?=
 =?us-ascii?Q?FyDtMaIwGHRsi7kTgw/VC/yIou0taca7kI8/YC4gMq6FXAUX2EznyUwSpyMx?=
 =?us-ascii?Q?ybDZFCkvcTTV5jGIDMZwmFP32hfsedkqaMNbZ14v9HFNiGuJCNN2b44i1HUv?=
 =?us-ascii?Q?h01kT/agQ5+0mnW7nNiwZIioAMVTcZG+ACf6ijaS01UtaHPb7tAGsrM6Kf2o?=
 =?us-ascii?Q?Cbx5rCWSr7H397ElIt0mKB/BPGvn6rKYOG2lhiUkO872/9tkbUm/VdDc5Tiu?=
 =?us-ascii?Q?8Zi4dXmHvE557K6RpEsoCxXo/CT2Rf6XBmHSQgJIiQoKmjrf2T14HWQRH7Ya?=
 =?us-ascii?Q?aXhSdcmakJdXoWnSta2n6p1GfBBkAtihBwWUImDeg+9gADpAzYVM+zWBc0sV?=
 =?us-ascii?Q?eZm6rPNkmTLlVTp4PRPeVbpRMG/MO3BBfzFFYhuwVFvW1nePfXeXSzGPOXY5?=
 =?us-ascii?Q?lxiQzs0xv2F/IF731l+LsXXQrq1gNWvF1R7PgPsmhDkb4ZE7liS69/oviyp+?=
 =?us-ascii?Q?xbtyc6klx7pI6dsMm50QgA6H+D0JdCa+JSh1uQI+zlgXE2Ckhh+5Vd2Bffr1?=
 =?us-ascii?Q?nzyOdlq7HGfs87prGd0HmZA4ECFI2HDY2f7v8yMg1KUeRrFtVxf1nGdOzweB?=
 =?us-ascii?Q?TURpubDZXefP1EXsnsEwSy/thfdroJi8lALFJ3NTN4ettPxmM+yyLFiYaWpk?=
 =?us-ascii?Q?N/1WyTV1H4LVf7qByGqTXGjj05do7dBFposxn0aptfw1dz6pACfbcapo6Tl6?=
 =?us-ascii?Q?2tAx9iP9+0T1PdxMcczxvy8GqJalJlflka4pPjRPr/K8EoLU8KNB819VXaWl?=
 =?us-ascii?Q?T2cl2w8TeV+yi1CH+L5zX0YZzPDPOXjw4/am02azhLCpOqcyMGU34M1SahT6?=
 =?us-ascii?Q?85zT1heMXrPGP56OxWwyaEgNe5++4D/LCPSGfWwYGvvPboHRs0RLBn6jVtO+?=
 =?us-ascii?Q?nDqgDl7/xaQA/T9zjSFKnct+TP+McXKaiT/nkfxZNJaFUpfkXUkZVTBdZUWc?=
 =?us-ascii?Q?KcSHS4PqrFEXR1mIJnjVEy8zOGesiQQ/OTvyav0qcLLM20eJuWhKpluxTCg1?=
 =?us-ascii?Q?99dG6csy/YT151J8c8MDbx8Y1RPJX4GGNHZ7yvRL55IvSh9UezvxMmvGdU1c?=
 =?us-ascii?Q?breGXAyQ9uu8ixhzX8Rnsd13p9iu9aQCLZvFlrWf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a78ef019-1c4b-438f-4241-08db6e15604b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 02:57:09.5898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEk+psNTixfany0BJrmTGile5jLquU/OLCPnYDTabBngB3VY2BTAa1waYfyFwCDuneCrWXEEVksSh8NxA2N/bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6540
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
> On Wed, Jun 14, 2023 at 12:16:27PM -0700, Ira Weiny wrote:
> 
> Is there a repo you can share?

:-/  I did not push this version anywhere.  I can recreate and push if you
like.  V2 will be based on Dan's new 12 patch clean up series.

https://lore.kernel.org/all/168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com/

> If not, how about a recipe for applying these to cxl/next?

Sure.  Starting from v6.5-rc5

b4 shazam 168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com
b4 shazam 20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com

Will get you this branch.

> (Not trying to run, just want to load and view)
> 
> Thanks!

Sure.

Ira
