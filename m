Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2821C74A5B
	for <linux-cxl@archiver.kernel.org>; Wed, 29 Mar 2023 22:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjC2WYf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 29 Mar 2023 18:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjC2WYd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 29 Mar 2023 18:24:33 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219B51FC1
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 15:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLwDg+6kJDVMnvAvIJzKqXNwmyGST73qMUxryzPthymhEfzGCDpStidT+Dc6mbJCGRB902FxLMsSQmhkvD4X/MC9rNPJewt84B6vv0LPtYnrSShd/OHenI5rZkz2mFWBoCqzY4xIacD+OTnJ8P/2m4/r15IJrgT5CPQpi113Rm41LuOax69WKYyc7KW7zfTZ/e6bGySpNABTR9Od21j5Fm9a/okwBA29++ToSqCfutCnwREQGdC5et+PmE2ut/yNMJXvFMWLIpF26BTWOTlrBtfzXxE0I7cmlVj9y4qYp7OufN3yW7rYMR97xY3/Yqiq/VInjQ14UlM4DOuGzeuhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndRpP6xyN3ZH9s0O8FdEx3+Ta6fgbQh9ls4yYeOm2Yg=;
 b=JKst3TUeHTgs+0cnNK8ixMiDkeWmve1QwOCvqHBnuoMy0kR87nW7raYY9R9MsBiNDRdxe4VegXWEdDNVR0M3Rs91UUQ12YBwmxBdWQLv9gCo1waP87VppgNR6XcxnaBZ5PsEOl25UzAyCuefiFLJSUWvbfdIDIiP40FvOfxJVVyId5huVsNN20f4xrttGehsh4dvWE7waf8jg2MmFB3DCWtjhj+1URyAd0Ari8sI57/38JWHF99PpQWu3iVJZ8qX4880Id1GiyKq4sAh/N+1NwRyZSFl3HP8LbAs7d7kU4SySexxEao7ChoMxDk/pMKeryFwy5Jv04GPBKpSILZlhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndRpP6xyN3ZH9s0O8FdEx3+Ta6fgbQh9ls4yYeOm2Yg=;
 b=xVny+hLdDgsB+klasdl9NtfDW4hpGo1DXBQPsE+HTD+euPJm8CAeFfp2Xa57Bd6gR3bE6EjhXgNBJDukic+nM9rocogWyBj8+RISwArP7vUa7jO6lDOwn1VRy7ZFsCi86ktEDTBVUAXjIue2KEHOdXgvzZrho2lcdU2vQMpV/FA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA0PR17MB6227.namprd17.prod.outlook.com (2603:10b6:208:441::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 22:24:27 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 22:24:26 +0000
Date:   Wed, 29 Mar 2023 06:38:03 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dave.jiang@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] cxl/port: Fix find_cxl_root() for RCDs and simplify it
Message-ID: <ZCQVCwC+JyHZMoar@memverge.com>
References: <168002857715.50647.344876437247313909.stgit@dwillia2-xfh.jf.intel.com>
 <ZCPLJme6t+Vm9wXY@memverge.com>
 <6424b0295461c_c72229470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZCQSnlEmhGXF5gnW@memverge.com>
 <6424b9eca6bb2_c72229462@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6424b9eca6bb2_c72229462@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BYAPR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::24) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA0PR17MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca3c220-ed15-4a8a-e0fc-08db30a45b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6LD9GYW14TnuUcprSwOYrrI3o+8AZyFWNdyAGnukhnBgTboxx/m9MPxAwWeQlGcL+9JeXbHRMp+B6HwenPo3mWz2Y0kd1v8S9E1YrDzz2Re7y8nmctbRidS7nPyQx8/aq1M/EZ5zbEAdIuDzXB+Az0m8h98J4a+rphGM9ROBakO/t80N0ICtvBKc8V5vX+6nMLHnsl8jSEOX0mujcH1SZHsmIbSwGiagabRirBVvAwx7dmr6Jz+VWmWVuxSDtgTpX7Aq7CbAJWaoXeR5wjmTrP57pjSFczTbupflQgF45eBmzEgmHd+etFqsmaqJ97c8CDXtlCaoaKsmbT5gKIl5wDaU5tdBQgaDAjyJzEAmirUvlX760s1vUowayUmxovyDdr4au7IvxS1FLo1uYowRpYdhrvvTujlTD/fFv2e6lUwKbWfSCH9MCwsWR3ogN2U55WGVNkvNSNWGcCFiFDqfHiPG6+gmyMkqXCiDfr0nP6Se62t2GJfqs8Mes0JNPKKZRemsmhAImjD49Xa5mmBKoAVWqPuAn210RnG6MEh3T3X8oKMdL5/0yV50KJWbexKQy6rKD47LY5x3HtIu/5T+vcR2PDqY/TK/Rx5IUQhO80g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(39850400004)(366004)(451199021)(2906002)(38100700002)(44832011)(966005)(6486002)(8676002)(36756003)(66476007)(6916009)(41300700001)(66946007)(66556008)(316002)(4326008)(478600001)(5660300002)(83380400001)(2616005)(186003)(6666004)(6506007)(86362001)(6512007)(26005)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L+ghB1WZnHCD5d9lldz8QehPocALRphquR8D29nDsboDyEvNPsdx+cudOsbi?=
 =?us-ascii?Q?GaYgrEQGR3o9FIyXC5Npdi200cDcJL03Kgy057PXgWz2cOsGGxqwCEjH3DXO?=
 =?us-ascii?Q?fOXCb1ZS0Nr8G5Q4h31fDFVL0js3mK8XsNN9tsbOyCRyMy+NKhO022q5hxpT?=
 =?us-ascii?Q?g8G7R1t/WeG0IQhYHo67om79+PHefdCX34TRtIt9qmRRqYidWT99q4mibrN4?=
 =?us-ascii?Q?Y3kiiWwHUGOaWDIupMLiWR424F4j452fh8IOB6v3yM57bnclDVaTR0xcjRH3?=
 =?us-ascii?Q?eKYQUNLBJYcxNbHK0D0UBtafZCLQ8d93pjhVaXF1mEtEyF6EcSKdap2FsMzz?=
 =?us-ascii?Q?naIzokxF5nz2+VmBAL8kJmD/FLo0JotamocEXI8PQVbemBh9Urhnls0MMWmY?=
 =?us-ascii?Q?py3QVcPKyREYABuHZL1ziDMZlJKsKORWjB6eYor7bjjcI7iiTIMxsecE5L6a?=
 =?us-ascii?Q?jTMf4r34A5QdSBYKE1VMvEvPF+Mrdn0+nLo0+czvj2B1jxh4gA5olDbPGa1a?=
 =?us-ascii?Q?E64doWTQk4hVrpax7uxuJZ96GyE9CKJ9v5LNiIZFZlF8QvWGp3RKSrVu7jaX?=
 =?us-ascii?Q?RNoKJ0LvMiByJDfnVN5/jAg8jyNR2ROCgMKJVAPL7LGoIqBSW5KuMIINuvDB?=
 =?us-ascii?Q?6H168KWwgYEbrJ/h+d+RPk2G5qw2V5U1f/ddI/OPEEZs7j1opr2SdZVeOcO4?=
 =?us-ascii?Q?KGJXe3GChH/VBpURZXsZpgmgFDJ9+c8EfpoQ/dRf4v+ntUOZhprYh040gntE?=
 =?us-ascii?Q?/NtW6clIrg/0b7lLQN0Fu2CS5x0OV98dZr8yqiSIhdjIq1T4oni/c3GyJ8Jd?=
 =?us-ascii?Q?AIq3jsec81cT8OpLQ+Xn7SYdU3HNHQdVpT+iho/RklrSY/lXfvEzLGjTmzrn?=
 =?us-ascii?Q?/cH6RWLgC7hICOrj7ZXb8rH+s2qDtWgoRdqcwRZJUaaftVJ0fzXq6E2GBOLo?=
 =?us-ascii?Q?pkGIQmpNA7E8wtpQlwR68RxnaC5hawth8Is/W68Pq7fiMFbOr5H5tTu4ICoI?=
 =?us-ascii?Q?gYmsUZt4FCwqOl14gbIPm//EKHS/re6tsjsXC7g9zjXZbt6/eeG5wbbSQg5h?=
 =?us-ascii?Q?4zO99EptF0wHgHZ5NO0HgwBVLUoH6+TviBsWbV6GxDAxyb8BaJu2SZKXc7iW?=
 =?us-ascii?Q?EYaf1nNuJPbQ/9ov+pIUdD9O3UxVGuKPkU01vUTBw1GfKl/06mPnN0+nHec+?=
 =?us-ascii?Q?C9joDbTOIxswaLJu5o8D3u9RSYiyJJsneHZl+MBrtgu6rAW+nR/jWVN7uPZn?=
 =?us-ascii?Q?gpb+onXVghY5r8D0lo1a4OMghMe7YBn6Qtmf+Gnh+erfBkPHqzDMFUuoVGXv?=
 =?us-ascii?Q?Ge1YCE+6p0jDUK47u9XpxR+IY5mqHM31g7KAwk7SnFo15lOSPxNjKhITQP2h?=
 =?us-ascii?Q?iO10bmLO5wsSTpbQNzPhdbu/Vz4MtmbPWnh2nBci4qQvUSHx1fWnVvy9hmeL?=
 =?us-ascii?Q?DauxobdMgTbKCsFKWBuYNT3f9g/m6ARssGj4TtmETAtbm0I95ydVp5oKSRxZ?=
 =?us-ascii?Q?YRfdyNTfFqTD5+QVB+e1PNOFWpd2ohtpxfzMqCDCW/a0e1gYhDiRKRgllO70?=
 =?us-ascii?Q?giDGiEZfRMfQVWFAInmKreURWAeRoTrDQAJZY0KoX/AkSsDPJw5aMI4YkRZW?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca3c220-ed15-4a8a-e0fc-08db30a45b4a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 22:24:26.9336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydg9Fh2HnIOVPG2dbAVLV8cbvv9ZHP3eSbTuH9qWjgt+S1ocgpeENAAiIP5SplPTfWTNu1fdW+ja2OqMoZt7P6//+NcuvbpxlsdkVsb6QSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR17MB6227
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 29, 2023 at 03:21:32PM -0700, Dan Williams wrote:
> Gregory Price wrote:
> > On Wed, Mar 29, 2023 at 02:39:53PM -0700, Dan Williams wrote:
> > > Gregory Price wrote:
> > > > On Tue, Mar 28, 2023 at 11:36:17AM -0700, Dan Williams wrote:
> > > > > The find_cxl_root() helper is used to lookup root decoders and other CXL
> > > > > platform topology information for a given endpoint. It turns out that
> > > > > for RCDs it has never worked. The result of find_cxl_root(&cxlmd->dev)
> > > > > is always NULL for the RCH topology case because it expects to find a
> > > > > cxl_port at the host-bridge. RCH topologies only have the root cxl_port
> > > > > object with the host-bridge as a dport. While there are no reports of
> > > > > this being a problem to date, by inspection region enumeration should
> > > > > crash as a result of this problem, and it does in a local unit test for
> > > > > this scenario.
> > > > > 
> > > > > However, an observation that ever since:
> > > > > 
> > > > > commit f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> > > > > 
> > > > > ...all callers of find_cxl_root() occur after the memdev connection to
> > > > > the port topology has been established. That means that find_cxl_root()
> > > > > can be simplified to a walk of the endpoint port topology to the root.
> > > > > Switch to that arrangement which also fixes the RCD bug.
> > > > > 
> > > > > Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > [..]
> > > > Is it expected that RCD's will fail when set to EFI_MEMORY_SP?  If
> > > > that's the case, then this (and the other patch) look safe and do not
> > > > produce regression.
> > > > 
> > > > Just want to capture this behavior, as it appears there may be other
> > > > issues related to RCH/RCD combinations.
> > > 
> > > After I posted this fix testing revealed the need for a few more fixes,
> > > now posted. Most importantly for accessing range register defined
> > > regions is this new fix:
> > > 
> > > http://lore.kernel.org/r/168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com
> > 
> > Are these patches on top of an unpushed cxl branch? I'm having a hard
> > time finding the base patch to apply these to.
> 
> Pushed a preview with all pending fixes applied here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.3/fixes

o7 will give it all a spin tonight and have some tags for you

~Gregory
