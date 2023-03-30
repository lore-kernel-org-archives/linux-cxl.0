Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2682FC6FD1D
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 14:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjC3OvT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 10:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjC3OvS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 10:51:18 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A99900D
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 07:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViowWFxH39glL2otdcWxm2DlQM58N0YRpRTCQeAIsSmspmdi40a9/43E87PsFZRbNoQlon5HiaBXY0Ot9xG/9PRf5iIQGxfB3IvW2StbiQtSRQkm2XnCSXiVsVhE2l6HEWG7Y3gf7qW/dUe4PzMFw8dOT+WTNMutDNsJ2dClHojSJl8KkMGFZoSAaAuR7YY4A9dPwICznYsjNumbk1c44LnQOtWvCkR+scHU9jxWqQ3D3dH3w20wUTIxRpI6kOTC1bVoGroEFsSgom1MEmUMHPw4/avMmUSKz1mh8ygJTUahF34XISw2r5VPAGf3U5RnW1y9KRH//U/k/Qmll0Q45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bObu8aKPXod3KHL2Se5ihFkf2HoeIiJNaYVgSLRtpc=;
 b=iy6RDcyB60gp+TUhqSpgxXaK57I0JQAeKN8QdRmhmTq1eui6UtMjuJbwchX+JHv5p3s/l8I6JbAPstsEaKGqFFUGMUazZB/zoQRTCfAzKDKVZ3LwXDVOW1A9qRFfMrJcNBpg+RSoDKad7SdthOTnBNe+DPF1V/yzAeKcSULAbkL95GLxXpDImvKWkneKnuaeom0J/M1m0xEn1Sm9TZawlLMZiKQ/9OBgkd3tRF3rBJrNBOKexYtXT/CTtfnz0QzDZQApewuDdUxO/opG1gzQ+RGwg/+wcZ1G7Heslf5upY0qNnvWJbICi3/gminy6warv7dMIevBIFN8nZaCFZafcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bObu8aKPXod3KHL2Se5ihFkf2HoeIiJNaYVgSLRtpc=;
 b=v/5zJ5PrlAPllH1N4ubn8gp9ZvtNHVy9wX0BL7aOT1geux/M73+hpjGzOAGrf98tNhXoJTXISi4ADoSYipHcngo5HMaRV2XwSJCjOl/qapczGYlzBZXqGMTJ9CGHH7PkkNWtS0kvNZjN+Rl+zs/lVOBvKPOB4FVXMX53eNewdxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA1PR17MB5540.namprd17.prod.outlook.com (2603:10b6:806:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Thu, 30 Mar
 2023 14:51:12 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 14:51:12 +0000
Date:   Thu, 30 Mar 2023 00:27:02 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Message-ID: <ZCUPlnQYVRCumy2O@memverge.com>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
 <ZCRhhUDcmypVKu0X@memverge.com>
 <64250e45bea49_c722294c2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZCRzh0VLSVF/7jya@memverge.com>
 <64252d214f0b_c7222942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64252d214f0b_c7222942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BYAPR01CA0063.prod.exchangelabs.com (2603:10b6:a03:94::40)
 To SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA1PR17MB5540:EE_
X-MS-Office365-Filtering-Correlation-Id: 341a6f12-9f2a-4773-8c60-08db312e346c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FSZfW0J8yl629iaMNnct6KD0h6FxCjgYqOvepBxb2VIo0w598PwpZXx02bkvxzq/KFxd+5bAYE/LEiBLDzSlIelojRAAYZuIOE879x33F9B53e9g1KMR3d1TfxbY+YL1twKh4+VsnHKKLlmhM0Af+zOdpvlNVTtQxNlOmWh39Lvo0pFm0WqiMUe/kr8IsC/6ErJeBu9qU7C5VHZEMrJyBSMF9CvVIIEK/GrqKmIA5r23W/q8/ihE4Ph44cBy3O8SKFoaZa/Pnya/hVRNYxUUUgQUcVltMfKeUrFczTWjj2buSpcYMgDJtz0MNVP0QlNBZORPehACqdy2QzWC2/iaTP3FXSRzlroc3u7br5Xf79BZxthjtn7JHsXhaPsK0U9qlWKGRqHlltXvTxVQcSWdDU3unqagwjFn150Fgubpgbf+o9+HX3SoKEGN3ffcH2HAzHU2/lVepIGJhYGFRbvjo2WR+5MYCHo9g45ACAVPT0mkjZo7Y3vsVQ1oiq5ErUeHUZPfb1jvYNXzm7pxwHGUJfKSwYZwyIudyjLFfQhHFMp0Vw7A6OFLKzgbNsfsTmEq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(376002)(396003)(39840400004)(451199021)(6512007)(6666004)(36756003)(2616005)(2906002)(44832011)(83380400001)(8936002)(6486002)(5660300002)(316002)(66946007)(478600001)(8676002)(6916009)(186003)(38100700002)(41300700001)(86362001)(66556008)(4326008)(26005)(6506007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hyJAIEL19k0I+1oh1eAfb16iDsBN0AmkvwQ9wZU5aVh1tEHKTt523nVaLbNS?=
 =?us-ascii?Q?jicUhOGSI6rBJ7SzOYjI/fQTf6IX6/bNyZ7hdgbIoJqJGOGh1T8Lokk949Ez?=
 =?us-ascii?Q?Dkp7fisXEXIb8qFzEY6hV4sHcwIYEGmiV7wHMHtzA3I1UHO4A1kA6SdwTePX?=
 =?us-ascii?Q?nvGLIVGpEak/0C3p1/8b64JA+l5vIRqAItpyTbJB2MlJ/oLxLUDnH7HArOck?=
 =?us-ascii?Q?0c4PYy3T5L3nTaRSNxqDe155RT2lMrU942TT+PpNHNR+BVolagUDX2Jyt/Su?=
 =?us-ascii?Q?l03ARl4WxqrLb8DeRQ7Tlf3upIerR3t3SPxWr//60TPt5zLdmSuElANu6mn2?=
 =?us-ascii?Q?Q27ZDqbyKQAFcTOXVIM5smwPLfgAohBKmQ0csC0Cc3f/jsSgmcx03prb1ojQ?=
 =?us-ascii?Q?Crl09JzVW2x2nposO7tSd6y9IZSCSD0bFtQQBlxypVUTVX1zJO1NlzFKq0al?=
 =?us-ascii?Q?D46FCtVf/+xtBjRuZ+VP5kX1TzsbcMfsTVRqGVwOQNhyQzHnMprixbZJMQsK?=
 =?us-ascii?Q?iRaQdBIjEuur+sXJAPfNiiaUU0xNabFHPpF9aJ0NJtnP7aoxATHwwYy2fRvv?=
 =?us-ascii?Q?/ePcX/x0VKnuxBTV5NDBzYZgSDqNj+gBBlJLTEw8Ww9Zw87KoeAn6o5OzvN0?=
 =?us-ascii?Q?nmTJDIr2FwbXyde2PSWhT6SAgGIj9wPGM0jjVIoXfTLCJFWn57A55JQncV7L?=
 =?us-ascii?Q?DT+d1/E9AFBhagVDMHKS3BkGyUn/kZDyPofMJ/aF42KRw+NJo6M9EAzJ1xo7?=
 =?us-ascii?Q?IbeuXx0ywDGcHh5ERHSYCHSRW10LtbNBaHWd7VH3KZ+z00U2ti0A31JSQ8ws?=
 =?us-ascii?Q?rgKlDRGT22GuHQiXEVlF18IOBkRuoth5/jRLKxbaEs+2iyspzggbv6/zpqED?=
 =?us-ascii?Q?outZYv0FOCx/kwMakhXZ1Hrq/aT+KWmrH079heRKQDlPV8RMekU4D77fN0e4?=
 =?us-ascii?Q?Xx0950og0OxGbA7l4QixQIA2GapxU2AfUoWF4KlpJ4g5bpdEhIMj+UBtarTB?=
 =?us-ascii?Q?2am3ecu5Z74YChNrkKiOs2Wad41Mv3uBLZZ4LRU5vDgS+1ZRqrNRpif2AElp?=
 =?us-ascii?Q?GWKqZbApGF2XwpWsbFVgwIwXhbQBjPyEvnDRMen5SZpi2Wh66GWD4Y/Ih/Yz?=
 =?us-ascii?Q?DlUfLryEr/NsTKayplM9XQV2PGBzrd3ZRn4wp5AIxdj1ik6tcXTWnlYkBL1M?=
 =?us-ascii?Q?JOFHAtcmSZwTSAK4+p/qoB0msxhHHnPwrgPAi/qiXoF8+QJ5WmOfS0y1pTsq?=
 =?us-ascii?Q?kInAH6bFXnc5Gc7GzgABrs5h4SZBhSDWxH/We9YsjVUjSGYNUxubZqPGsXbQ?=
 =?us-ascii?Q?VQT+V3COu1eG25eWoj2j8zPDXThUHKJc+AtKvhnRYRPqoGsbIbdzUWMNSjmH?=
 =?us-ascii?Q?MjbW4derVZd4TxVGpGjuwRgVMrLupVXr2ZqDr4cN7i3+CNZADaZl0l1CREMP?=
 =?us-ascii?Q?G5U/S6dmg6ye4zStN6x7NtzxrS/gRWd876fNn1MNE63vnTjW1PoemcuhCp6R?=
 =?us-ascii?Q?c8NvnfTl0tyxNcSUEPghzd3BOwatJ36OkkweniZPumVPR5uzI40K1rkXulnM?=
 =?us-ascii?Q?JLgIIGB+XlmREkuf+GAfCvrWK5FNk7ehNtiIX4C6io5l1tcY2oB2j0vBxbi8?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341a6f12-9f2a-4773-8c60-08db312e346c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:51:12.2944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AwZSgQoGIMuShYZMKyIEvV1w0J9yLq+QmOL/kOayqpKW4cw4dAAXE4r/Cn3sEUJ08qZUZC2w3MF5GGOOCsltPEzSjHbMxHgip4bhtwYBCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5540
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 29, 2023 at 11:33:05PM -0700, Dan Williams wrote:
> Gregory Price wrote:
> > On Wed, Mar 29, 2023 at 09:21:25PM -0700, Dan Williams wrote:
> > > > Is the DVSEC Range Register expected to be programmed by bios, and are
> > > > not being programmed correctly?
> > > 
> > > This debug experiment makes me think perhaps the *device* is at fault,
> > > not the BIOS. Perhaps the device accepts writes to CXL_DVSEC_RANGE_BASE
> > > to set up the decode as expected, but reads return 0? That's the only
> > > way that I can see that forcing that offset results in successfully
> > > talking to memory.
> > > 
> > 
> > Oh, i meant to add that i tested whether the memory is accessible via
> > numactl --membind=1 with both memhog and a python prompt, and things
> > worked just fine.  So memory works.
> 
> One other theory is that the device is correct, but the platform CXL
> window accepts transactions at an offset and then removes that offset
> when transmitting the address down the CXL port. So device thinks its
> decoding 0x0 and never sees the offset removed by the host bridge.

Wouldn't that be against the spec?  I thought the device intended to
receive HPA and do its decode accordingly.

Otherwise you could have multiple devices programmed capable of decoding
0x0, which is already the device address, so there's nothing to
"decode".

I'll follow up as I learn more, this is concerning.  Certainly explains
why every time I switch hardware nothing seems to work quite right.

~Gregory
