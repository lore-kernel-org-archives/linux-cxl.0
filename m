Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A68C38142
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 16:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjAaQ5C (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 11:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjAaQ5B (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 11:57:01 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31C813DF0
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 08:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675184220; x=1706720220;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nVQ7CRk0DHozr2TfM9fo696ErpSkO96o8ZrLLPZbAxg=;
  b=P7lE1QQZoS/DN6+3I5SQQ/TjCb8AcRRlWoY7PdH8on5Dp6H4j+gFo7mi
   qhAFCD8pta+SIZkfyq/dC15ifgO1g1XZ8JtTvr8iYESBeSFTQxWS5/kTs
   5GUN78A/jtYkixMZxLjw+M0OpKpnonas/DRxupWLUcpxPXyDsC3ecYw7m
   8I4+Q7fUm0GYVb0wB0IeTPz2uvWSFG+3ieJRjpiFm2aSdk3YMmDegNqqa
   Suc5xI/rTaIQkOBFhL5izsPmSacJx3c3wKwPp1Y49Rv2MRoz2TCd7fwni
   ahSA04YZqzbiG5MeclW7QLZNSd6mwuRWTnG7SQ+jl/PdqCrAcBjYAt5fl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="414106614"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="414106614"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 08:56:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="728014005"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="728014005"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jan 2023 08:56:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 08:56:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 08:56:47 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 08:56:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTx0gxRsCnVREnroHMAJDW7+QsiAPLbJ7/I7k7mlaMTpKc+/Sw3fiQ/OYO3JbMCcxwyDXMKP/jAzToRpqhMVF2aaPEObNcbVFVtnmmEZjwlWsK0EZOqkO4c87RW+0ZEH9/B6PBk2IQoodgJvHcoqPqj94KXEj8qxnexfKbRZNl0g7LzQnlPXMat6XOkNkMAtLezAXkxPOYulf24PyqJn3eJj2ouG8IN3JMHiq7mRRnpqGNE7J58C7jQ3XPNt0MTgwYCtBCwieZyqvL7YGenWQUCitGqogp88sL4FZQ7M1clKEEqeWZZY1qbgypBzuqs/VRpUNdhX5acvBdvgYw+tQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqYYoOzJzQMivNhbbzjVAltKbs9iUBg9VbnyJ8fPTVs=;
 b=gvI3mTOQCqkkbYrh6aEucw2Su54Zc37nQNDcK7APktt5lhhwh5aszIjfLIUvuj7mrn4CPWZfS5PfE+ywAixkqkaY1y+H8hSJ1ZVvplgSTaefTpHEJdXdchBIOtmYFKq+4deUBc1Rlnlu5oYXG+8gAVPmpy24p0xbx+HcRRGztpa3LsL3ZUrBCyEcRtb+C7XRyHKah2WuFIzcsg46VzT4afReKqJwmaXw86SE/WjbjzyUTbKTNiJgX5f3m2IN4pV1X7j40Fx8I7G7MV7cKgeorkaJA87jI441ajbZC064IHlxKem5IaXTvEAiHhvx2qVtNEUfS0cRcAA9BNtoDCelaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7635.namprd11.prod.outlook.com (2603:10b6:510:28e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 16:56:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 16:56:45 +0000
Date:   Tue, 31 Jan 2023 08:56:43 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <63d9484b1724_8e2c294e4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
 <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
 <20230126185025.000016a0@huawei.com>
 <20230126193424.00005034@huawei.com>
 <Y9fRVu+yLza4d5Vt@memverge.com>
 <63d8242084087_3a36e529420@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9gva49IPFOXYlkH@memverge.com>
 <63d8504ecaa5_ea222294f4@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9h2VhGuraZfEJfD@memverge.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9h2VhGuraZfEJfD@memverge.com>
X-ClientProxiedBy: SJ0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e36dd5-f159-429e-2a7e-08db03ac227f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MRtxTvLiJv3U0Ve+pjTvw83vzd1pKgcrMqalx394kn0YQxQqlXDsuYvxhcGYM9VTvm4eIWyTYyFqFYOxQ8tHButtYAU9ur5ol2uY2y99K+tTzH6JlZBx7K5jXRDK4+1AxSpmZrOEVMMZHfhH86a1tWxK2FSgs9BPt97F4ub3tZENJpA8xp0vOQZtuaxBQO0fvfsJ/uIQ6Hq0IC0SuVR5+o5P2qqL3Li0j34IHR8P8Lw+duxsIm2mLTVLf796xXaPoEv73nbC30zhviK7LATcrnTRY7aaRGrJgly9YoCBlg30FnKnVNgFj+5mEA1uhm0n8srXt2DP4Vgq10jg1g/KpGBXmRYdB2wblGrj6WT9Ssmxdk8RTQl9WZv0k/y3/tLRCAdxzQV7JCJY/b5/1pVSXyRfcZ8lKa/WwOIXexDvl1mp3dF6OxFDGgYGpAjOhzLQqw7Hdc4aHoJoSLSnOI+4iAktQaSrOa5X1n3uXpqA4MSE6p973GrqJmzT3FEFWqysS+19vXV1nEosJaLrLysfQqnBN7JpPkqGFp0YxtOXnwH047qHkjWIIEBlQ0N1fe7vz/mBIYuYWlJBwaGj+BZbzq+FewpMYFqx4NgJRf+s1biDE20Gqa48qDMJ+DkDAfRspRbXXTRm+ZdIudH3yo7znR0/3clQqM5IYB3fuifwntRAIMQIodPQdbHJ0LNcBcS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199018)(86362001)(38100700002)(82960400001)(41300700001)(5660300002)(110136005)(316002)(66946007)(66476007)(66556008)(4326008)(8936002)(8676002)(2906002)(6486002)(478600001)(6512007)(186003)(26005)(9686003)(966005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGMveEQ2UkJoM2NldU8xdUVGUHl5ZmRZTFpPRlo2aG9SRzNkMVRuYkZkZ29V?=
 =?utf-8?B?Tm9CazNkZ1hNdUw4a0xkcnpYUHhwUDlsL3JSSWQ3RGFQU2xlVU5NUWh6bG4w?=
 =?utf-8?B?QTlZS2JiSGMyeWpZTmZRNGg3dXkrS3ovWGRnelU2WXpBaldjb3hWOVViS0JB?=
 =?utf-8?B?UWZhSVZraklKZllTQWx0UC9WOVMrWEIvc2xZMHUzV0lJbGVpcUN3QzBzcm13?=
 =?utf-8?B?UkVId3dYNEI1NW43TzlpRG0rUFo4bGI4K2hVWXlldzJnQ3h2WmhBY3pFZFYx?=
 =?utf-8?B?SVR0akp6T014NGxqa3hqN0haTVFUNU8yTnBITExWVkZNQmJPdEw5MEpEc1dU?=
 =?utf-8?B?bmJsaXRPTGZQRUFSS2ZwVEdzU0JOSHRKOUt4dnFhTVUrL1Q5b1pxRmI0anQ5?=
 =?utf-8?B?L3JVMGNMLy92SVJqM2JTVUJldzZkckx4RGNqODFCbWlZNmRySXlJbGx6eW8y?=
 =?utf-8?B?NXBHWDJDL1pFODhuMzlFMUp0SXBpNGRVOWJCQmhNeVdhc3lMZ2hncUljdkVZ?=
 =?utf-8?B?V2FNbm9JR2FKN1pLdnFRR01sbWlSbkRRdlNKWFdOQkUzazRSa2laUGFLLzk4?=
 =?utf-8?B?cjd4TnBXS3FsZkRlSXJycklrNi9pUFQrUGpnYi92Y0VMWGZDT1krMm45V1pj?=
 =?utf-8?B?QnlhNnkrY0I4Skd6dlpmMG1Nd0RGRVlpQkxkek5mUVJsUDQzNHRJcGVHVEg3?=
 =?utf-8?B?akdjODVsV05iY1R0ejFlTFUwMU9OWkR5MHZXWUVjN0JFck16TW14QlNwcHhn?=
 =?utf-8?B?RkpNQ2g4REFoanJ5ZklJdzJCN1JhbVRCK3AzSGhVM1BtYUNvNlNEUU1KNzVl?=
 =?utf-8?B?ZXZ2cEFtRnY3Q0lhNmdrVUNKM3JjYjJUeDZGcmg5MlE2WkpkSzhJMlZDbXBi?=
 =?utf-8?B?cmc2cGFveTlNVXlHbjY2V2dKM21jN0Rra0tpSU1PQjRvK3g2TE1QUExVUExL?=
 =?utf-8?B?cFpxN3dUeVY4ZGNZS1NmeGVua0lIc0o1cTdHa0J5ZmhXbWpjVHJvWmdxQmM5?=
 =?utf-8?B?cGZSSmVzV3AvNy9Jcnh2bTZ1c0d3Nm4vMHVTY2ZkOVY2aktoZ0VHdFMvdDNF?=
 =?utf-8?B?RmVldzMrd2FWOHkwRWpFZnR5UmJCSXlmQ01RZUhHejQ3S3k4TGVTRXVwOUY2?=
 =?utf-8?B?TGtGODBHK204bjFUUkoyK1FZQkQ5Ty9wYlJrcDNZUmdhYlBWenkyeG1xc2pt?=
 =?utf-8?B?anlUdWVIWHdlS2tlaE9kU3JwNmFOYXB1VFI2V3l2eHZQbGFBb095M3BJRlky?=
 =?utf-8?B?K2pnQXFQVHZmak1YbkpzdHkxMGNibis5dXpYV2FjMHk2ZW5jV3dUVjVNWnR0?=
 =?utf-8?B?cE9HSDhVcHhOVGNhSm5TUFFxSkxldDRtODhXMndVcFNBOUlseGU0K09FRUtZ?=
 =?utf-8?B?NkxZdWlmd3Vzb1NXbmtGSURjVVE3Y01xVWNCSDVMMzA4N2ZGRTRSYXhwbDdM?=
 =?utf-8?B?NjMvQ2tVclhtenc0Mld0bVRaOUxnZTBPR3lGNnd4d3h2RDlYeXdTbDZJNXUx?=
 =?utf-8?B?SEVIMmp1Q3lOK0FrcDg0d3lXOXZFRjMzVGxFaHFlMUlRVVVvSmgyK2h0cjZL?=
 =?utf-8?B?MlNiWFFibURiZUpTUFFWYkJ4Wjc4TDRhWDZ3NGl4WDNBdUM3bW16dlpBRThu?=
 =?utf-8?B?czBPQU83WjZZSnQ3SjNnOFo0dmpwYTVCcFhmRVZwdTRDcVpKSVE5OHBwcTho?=
 =?utf-8?B?b3Vad3hsN25rRUhSYU0rNXd1YUo0QWlXY0ZwWEpYQytuOHUySk5UVGRZU1pr?=
 =?utf-8?B?UkVQU3JjWjRKd3hsclVjNG8wZC9OekZ3RS8wOXZmbWRsdURHWFpybFhnVUJa?=
 =?utf-8?B?QTFaYWQzUlVEWG55VUhWYStJaFlHSzlHK1d5NlFVSXMwL3BsaEtyRkphUVVv?=
 =?utf-8?B?bkw5U05ycnBQQ1VCdWJtclJpbS9PN1E1b3RRSG9Sclc1dHMyL1pjV3hWeDli?=
 =?utf-8?B?a2RqNXFjZUhDSkRmQUpZTjh0MU43Q3NHcWo3ZWRkNDVYM2kwa2d6TTRsYmtX?=
 =?utf-8?B?ejJFTkRHeUpsbzRqbjN2eHlWeStvOGxveFlWbFFiaU9aUjByL0xmZlZLNVNw?=
 =?utf-8?B?TytpZUI4N0I1Um0vZE5GdDJXNXZ2T1RzeHNuaHRqNzhnQ3Bvb2FGQjlVVDR6?=
 =?utf-8?B?RkI2OUtUbzQ2T1dFbnFWeVBvQ0VJQURGMUc2MUtjU2tzY0RoUDhURkZUM1RX?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e36dd5-f159-429e-2a7e-08db03ac227f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 16:56:45.2949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PS3IY/1QTiJdVicCB79ImeDdtEVhAPmFT9UraNrnH9LWNGCO/H4EyDNrmQzftoDl9RlNkc9rWx9o04rMexN+i9blxggUqI83cM0BWxQW3bU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7635
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price wrote:
> On Mon, Jan 30, 2023 at 03:18:38PM -0800, Dan Williams wrote:
> > Gregory Price wrote:
> > > On Mon, Jan 30, 2023 at 12:10:08PM -0800, Dan Williams wrote:
> > > > Gregory Price wrote:
> > > > [..]
> > > > > I found the same results.
> > > > > echo mem0 > /sys/bus/cxl/devices/region0/target0
> > > > > 
> > > > > Not sure if bug/missing feature, but after attaching a device to the
> > > > > target, you get no output when reading target0
> > > > > 
> > > > > ```
> > > > > [root@fedora ~]# cat /sys/bus/cxl/devices/region0/target0
> > > > > 
> > > > > [root@fedora ~]#
> > > > 
> > > > Hmm, did you not get:
> > > > 
> > > > "-bash: echo: write error: Invalid argument"
> > > > 
> > > > ...at that step? Because targetX expects an endpoint decoder, not a
> > > > memdev.
> > > > 
> > > 
> > > ¯\_(ツ)_/¯ bug?
> > > 
> > > I went through the kernel code and thought it was looking for a memdev
> > > but i guess i was wrong
> > > 
> > > // ... snip ...
> > >     dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> > >     if (!dev)
> > >       return -ENODEV;
> > > 
> > >     if (!is_endpoint_decoder(dev)) {
> > >       rc = -EINVAL;
> > >       goto out;
> > >     }
> > > // ... snip ...
> > 
> > Oh, yes, it is a bug. I fixed it up when I address this 0day report:
> > 
> > https://lore.kernel.org/linux-cxl/202301281313.kVrIreUj-lkp@intel.com/
> > 
> > ...I posted another spin of that branch with that fixed up.
> 
> 
> This worked for me, though it took me a bit to figure out how to wire
> everythign up - still not sure this is entirely correct but this is the
> string of commands that were required to successfully attach an endpoint
> decoder to the root decoder.
> 
> Note: The root decoder has interleave_(granularity=256, ways=1), and the
> region code appears to require the same granularity?  Does that mean
> we're stuck to 256b granularity? (unless i misread the code, which i'm
> about 75% sure i am).

You should be able to pick any CXL valid interleave-granularity when the
root-decoder is not interleaved like your configuration. If it is
interleaved then that interleave-setting dominates and is enforced for
downstream regions.
