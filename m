Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B263B798
	for <linux-cxl@vger.kernel.org>; Fri, 10 Nov 2023 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZiNWu4Y/"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C861446AC
	for <linux-cxl@vger.kernel.org>; Fri, 10 Nov 2023 12:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699647722; x=1731183722;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i2QfgzYqiw1UyofzYgAq2egcAziUU/LnFrld6RCjT7U=;
  b=ZiNWu4Y/9qr/4fi7DU2Kf5sj3bdeFpDPtEDir+nWN9+wX7Wcl4YWA7Tn
   ZQDKLP+F2jrjN/zrogy4c/dQK/murykpxqwnvh78uJkjl9IjtkCZijeVy
   DVnOHgx4btg1af5xyyuWF7ppbHJYEM2Cyo0xChNoGa8+8KkRWbsbcW+OF
   8H8Zq6ACyhWT17AazM3mQBunQfocQ8M8Q9FSu0fh7XKbSKVYNT/wyJdNJ
   sXy6CvJZ5f4U9nXAFFjJvN2llnq1GM8/0IjV4WF//vhPEgKncgclwbdtJ
   4tzF3TewIlDEKjSqfPPs+nOiGmQrtYZPmSlwQyw5/qATO9xMhcJVtpNn4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="476454923"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="476454923"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 12:22:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="829734782"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="829734782"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2023 12:22:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 12:22:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 12:22:02 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 12:22:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVGuxJQxjsse6pdurN7ypguq8mLZWNM6NIKXXrErf2kXCR0AIUTuRfgAC+14gd/oyKngZOES6rUXMwE3Nq2UsIzZFHXOsc1/6OldQ/kpisoc8q+Kxj+2Lkws8BcwCWWJZn2fvakTSOnSQTUdmifhD7ZfnRNcZc4CdkzU5gLPQ+VWJ2BuIeCW1S5PDqQkM+0TpIEmMflB0L5K9IvQgGk6/XZ+zRFVJflvPlPGPIeY1BwIvMXofcKnt0cyf3Nh398pETyTj1mPhtT4a1xkb5wrf4WS5jYc0MZ9UBP0Rx0062LUdUVvnikkm6xvNTaB7SOoLZdqCT1dj40ewbmG5leVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPG+wvBABqQzWQaDRitikcuVYhqTtOSqiWQYWknLN9M=;
 b=L7LGV86RrFwYO/+WRGjt5KupYHohUHuho2cE6fypxRa6cp63r7ICpCE6Gm75uSFnnIHuD/KVlH5zM7Jz9PGnlK/EGnc/oeccJWLDfpvk8TcrdoJxrckJszlWf1pEImjpiPQZqcqoc8tqHhUEwZLXBgfKHZRnUouTQtuyY1ZpOrcRSlNAnGNclPJ5hOjskc4AUsI/fVciab0Evzrtd/yDj6ZUKyKKc3TQtj/HrIz+2gkMEiFYN1njTMhBIPnu0hZZ6ZCxAcpBVcKxuPWQMfcQ7mVMPkL6ZDflYdZVeKFpTsEr9leDS4osqY/pY5Qlon3rYWTFvQvDxMEa/aRAEcLX5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7088.namprd11.prod.outlook.com (2603:10b6:806:2b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 20:21:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::a49a:5963:6db:77ce]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::a49a:5963:6db:77ce%5]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 20:21:58 +0000
Date: Fri, 10 Nov 2023 12:21:56 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <peterz@infradead.org>
Subject: Re: [PATCH] cxl: Add cxl_region_rwsem around commit_end write during
 decoder enumeration
Message-ID: <654e90e4349f9_46f0294da@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <169948110840.509375.13862681045079385425.stgit@djiang5-mobl3>
 <654d5f7285171_af98d2949e@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <654d5f7285171_af98d2949e@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:303:b5::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: b26f5de7-0013-4bc8-bcfc-08dbe22ab0c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJeJvOcHHo4E7SjRUy6QMLA9nvov8X28ZEVmzGyNcZzWqkgO3ALOawypnLq5QMr02sKNBEZOqEl0SQpb4ulw35UjT8TKCkEz45F89lL4bXXfucUgShJNy6IlqHd5Jj5Nb+8oGLifMJkFw1edb92JJaV2YIq1m8ZG2f6h1tS7r+sd394rVDlIQe8x9ktgJ12iSOvk30Wt/JJdrNYZ9cq8u/gP0ToZ3sAWNRlXAklSt0hXJd78K/v80dlFY1iM4QBe5I6FjmXVV6rRLdJKFIaz8pi62SVrWH2YagEMm0YWXM10iOIKocfhwpgI5cQllDOQc/ItoVqGY5SyxBARvvPP2XdFZWqrNbg5QYoBi+U1W1EudqJwkBr1RUSpkFpdKfjY7Wej8nt+zOUSNA8IeKohf6ajqhaJ2lj3c2uWXkewE8hOuJ8QhfEArtnpRbLpkDu08YFj4vCu65V9RWDN+gf6W4uRqnhrgMkaC3DnZrAqV1dgyanxku+RLgzcc+wDQHKvwcwn1Hae5C0yOHJrohYveSiULuteJU+1cSa5fTjuW0TNci8VswruOYqKY28syS27
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(6506007)(6512007)(9686003)(26005)(82960400001)(6486002)(478600001)(38100700002)(66946007)(8936002)(66556008)(110136005)(316002)(4326008)(2906002)(86362001)(5660300002)(41300700001)(66476007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MPcJTtGC+Q6LrPEeu40nZFZsL1HS0LWTFm3nKnVG3SaNubeU3OXIdT8Vy1n9?=
 =?us-ascii?Q?rWaNNiFz5KJvhm/onkLjhqUb3fvFL4Ouep2bAsyYFFG9BCr44L0nH+qHgRKZ?=
 =?us-ascii?Q?U25FQc5NvhY49WU3NxB5aLdefhmpGIUmx934iPTe8vNpcJW+G9Y8gJ8ek5f9?=
 =?us-ascii?Q?1wsIWe1QInUEMJeKt+qBs2AMc7t5MhEemOXCcK6lvdNT+4RbJn5Zej4Lp8Bp?=
 =?us-ascii?Q?mnuWcSMVa0jnWWb0tWJMB4LoXbv5hc7mwS31PSLG6BJJ0ZjIuv1j3LhPQ+Xo?=
 =?us-ascii?Q?lrioQGB6LwE+widL4kgkf/4f/SRtmD4ss5IAx6Puv3DxWQYCIU/QtAt+F70T?=
 =?us-ascii?Q?nY3rWSNCYvE0RQETUF4GOOlduKKmwGqfFYElwiy+hrSgMQikdKLAT9XZ58YC?=
 =?us-ascii?Q?NwurMyfBt/naI/1llFDM7hZcrbrH0E1aWURTlXuPaFt08rV62Apa6yyQtn02?=
 =?us-ascii?Q?wN1LgKTPaoYVmvs0v6AU6KJNOnJPlBJ3p8HVlWzSsAc6XmkA1xjzv+F9nIUK?=
 =?us-ascii?Q?WIC5apiZE9BqUs+UakFGXrGZEPLJXvXzQuDf6r2qjwj8biuclxPs0ISVYpM+?=
 =?us-ascii?Q?EOvUo75UtyFf2LRmhpO1jM5Jm54hfEeos9Jih7Dd0x7OU6omTigAy2NN5FvP?=
 =?us-ascii?Q?nplFbHT9TvSuv1+58C+X1Xs9EnpwGtPK6tj5KYosVOiP7SZg7LQU79ly5uMV?=
 =?us-ascii?Q?LyTdYeflxtRGUTXGw5E+B+exulFJQYn9Z4EHHfchbaYuQrXDXwASJOvN7svn?=
 =?us-ascii?Q?GGEM1e7vACq8egByVK1lxwOn783XHoZO8ZMVCbR6cJLAd6MXIv3maC78zzWa?=
 =?us-ascii?Q?JpJzaczAA7kaMohIBR7CD1o7+fXv5Ni0QXNcnri3IXtlddBkzqM1OAJ2aDVT?=
 =?us-ascii?Q?FXL3cjpCbwi3XNFi0WEu8Fej1s/uEjwzGiGYGASfMwXozYvEZ7nSTa58HOft?=
 =?us-ascii?Q?JAeFzw7PE3sn+sg81tKwBK00kuypVvxt/9ZkmsJTq2Hp08+IjoOHJqe+lLzq?=
 =?us-ascii?Q?e3KZIrHw5ig2R+AoJ786sU2nuhv7A8skUa6PpJQwP3Vkxc6XIQssGZK6e3Ar?=
 =?us-ascii?Q?GwMW4KbeL4Ux6rECzMT+EJ/6X8xoWa00Jas7u+Ol7NpdWTPzv1WUfMOk+HQT?=
 =?us-ascii?Q?K3ocNyrFVgoaV1D75VCI1nenbgjUAgW9GLz7Ejn7rYxi2a2YDARNuNd604HC?=
 =?us-ascii?Q?we5xQ6VpvKVDM2wCKC4Ys2OEgNtOcsXDISMI+uRwUH8HWDIkhNfXHJ2syhSZ?=
 =?us-ascii?Q?IaSW4NZ6EMonW48p1jriW1xb+xlpzsKn1dGudoQk5H5+R5cg/g8Zhb/Z+JJ+?=
 =?us-ascii?Q?O/O+8yqoc34cMKtLGZPQ9pMl8maAZ/NssB93z3tB2C2tyNGisINRDsbCErA4?=
 =?us-ascii?Q?4aqtF7aDKxCmCuWli3rNz+ckOmYUS2M9BBnEFjljebSl5J/pZFmNjl//UTKI?=
 =?us-ascii?Q?CTQqLTZGUjR+utM/5NKbFnUoI0zmBJsNx4sMub7kn0Q5d6duEnZsnaEV4MlS?=
 =?us-ascii?Q?STwSyXnwvK4VkXTHG+RXrqIR7QlVMdhhFFMsewI8RuYqs4pA0Rc+PZeFBcqs?=
 =?us-ascii?Q?Isv44xEjcUShfKvIJ8yDPXhbctuHd1NV6lLJ3/+IHFHIXGmSx8GaaKXysGf0?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b26f5de7-0013-4bc8-bcfc-08dbe22ab0c7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 20:21:58.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXejTxFKwZfKV3SRAXqkXXjVtnSjs0539vw6vvacbXTDOZZQjiaPQN1AQJ5FLYF5Gt/7TKX3fNmr6TKRzexPzZ96mDYFsMAlqGmM5QUl5+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7088
X-OriginatorOrg: intel.com

[ add Peter ]

Ira Weiny wrote:
> Dave Jiang wrote:
> > init_hdm_decoder() modifies port->commit_end without taking the
> > cxl_region_rwsem. An assert splat emitted by cxl_num_decoders_committed().
> > However looking at the code, it looks like the write version of the rwsem
> > needs to be taken due to the modification of commit_end. Wrap the write
> > version of the rwsem around reading and writing of commit_end.
> > 
> > Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[..]
> 
> This part of the patch seemed unbalanced to me.  Looking at the check for size
> == 0 I feel like it would be better to do that check first outside of the lock.
> 
> Something like below.
> 
> Ira
> 
> 14:36:11 > git di --patience
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 1cc9be85ba4c..370ba5e39363 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -839,12 +839,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>                         cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>                 else
>                         cxld->target_type = CXL_DECODER_DEVMEM;
> -               if (cxld->id != cxl_num_decoders_committed(port)) {
> -                       dev_warn(&port->dev,
> -                                "decoder%d.%d: Committed out of order\n",
> -                                port->id, cxld->id);
> -                       return -ENXIO;
> -               }
>  
>                 if (size == 0) {
>                         dev_warn(&port->dev,
> @@ -852,7 +846,17 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>                                  port->id, cxld->id);
>                         return -ENXIO;
>                 }
> +
> +               down_write(&cxl_region_rwsem);
> +               if (cxld->id != cxl_num_decoders_committed(port)) {
> +                       dev_warn(&port->dev,
> +                                "decoder%d.%d: Committed out of order\n",
> +                                port->id, cxld->id);
> +                       up_write(&cxl_region_rwsem);
> +                       return -ENXIO;
> +               }
>                 port->commit_end = cxld->id;
> +               up_write(&cxl_region_rwsem);
>         } else {
>                 if (cxled) {
>                         struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);

That is an improvement, but I was hoping the era of remembering to unlock on
error paths was over. I came up with this oneliner, but wondered if Peter acks
this from a coding style perpective:

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 1cc9be85ba4c..6452b10b80c0 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -831,7 +831,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
        };
 
        /* decoders are enabled if committed */
-       if (committed) {
+       if (committed) scoped_guard(rwsem_write, &cxl_region_rwsem) {
                cxld->flags |= CXL_DECODER_F_ENABLE;
                if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
                        cxld->flags |= CXL_DECODER_F_LOCK;


The alternative is a much more violent re-ident of the code to turn:

    if (...) scoped_guard(...) {
	...
    } else {
        ...
    }

...into:

    if (...) {
        scoped_guard(...) {
	    ...
        }
    } else {
        ...
    }

I know the coding-style does not allow:

    if (...) for (...) {

...but there are some instances of that pattern in the tree.
