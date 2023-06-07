Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE050C77B7A
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Jun 2023 18:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjFGSom (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Jun 2023 14:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjFGSol (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Jun 2023 14:44:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FE01712
        for <linux-cxl@vger.kernel.org>; Wed,  7 Jun 2023 11:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hr2Uwkg+KNN9cQRSIuCcAgN6zZP6+KNgZdujXlaDqjQR9Js1xLDUF0MvcLeJoQflenmqKrz+s+twKdHi665RZmH/32h+YdzW3r4x0cnZ3uCxkWSXWJxSAXdTROn1KFUPFLbeyOcso2TE4dx6UbS7O2WO2m3+LamSM7C3S9xoi0MsLN5qgi2VZDLHeZGAX/6LaGt3iYnGeSJqmzutPVsCgdCKa40A0jwnVt4PexEPNG6orvruNms99LNnr2oabgAXeP6Xbcli/uslx2lbNiqLUdptDgKU/lOmvX/jJNvcWg4D0Vy2lHRIRuySkPvEbFCjIG1WAeNfg6arVe7rVdqaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX9GuWvJozhkHCK3e7oKx6cC3GxupuGshcEEOoKB8D0=;
 b=DmO0g9S/YzkNgT63jyvgMcBKgPKKKdhu5BV6li+kJT3+ih7pEDm0+vJEQngVi5APlVX69vhm0M+xuHiGUoxvz7C9va8nbzdiyIMGsle+oWuihhzhZGjDVfpQy4T1dbHdNPUaYWvx5CzW6+OA8ZKk+XKP1paUpEixcOE3Xl7iqQCD8KmSVZAk9M6rEodprE9oExuFYeIDcN0FZO9BgXvIQG/dSXulNBF2EkhnYuw0KBN+FaYbEMmHOfZbBs8V+WpNNB6eawJ5JaUsk3QJHTGegM472K+4LfdukVMCxuPvX/HV8j46u3mHwOCPW4t6bRxKjlOYpNPyuvXC+tE7/RsVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX9GuWvJozhkHCK3e7oKx6cC3GxupuGshcEEOoKB8D0=;
 b=P4kI9XJJFLYD23K3fZWP04uOKtq61DUrRKWXfTrU8gO5QmF3sUdgpc/b82RubiR51fyQdM+2Dxu5U43iPprio3ClxgJncRoht8+FcPbzokoEsz/CS6XWESuOykiVfqR/Fyi5Y8uxyfhTSfjbebDNNdqpzZw8Ita1E7WGqUhrU8rcz4VqVzayH1bU4UylzFQ4Ssrf23RfTzRadt1DQr7VKLNR3L26euByeBa+A2KYSnxFAEd7GaMAqFaIMvybQpEuILUrMEraWVh5pMvkjg7h4CTuas7f2qKgj1+Mdj9ygQH8NZySEIW6gG4bO0zdKtln3e8A6lV4KP9apF5KCWs1YQ==
Received: from BYAPR12MB3336.namprd12.prod.outlook.com (2603:10b6:a03:d7::26)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 18:44:37 +0000
Received: from BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::561f:3221:5035:6fe1]) by BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::561f:3221:5035:6fe1%6]) with mapi id 15.20.6455.026; Wed, 7 Jun 2023
 18:44:36 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "catalin.marinas@arm.com" <Catalin.Marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Thread-Topic: Questions about CXL device (type 3 memory) hotplug
Thread-Index: AdmMgx3ueFURs12qRVC17Zugj/nYpgAiAciAABux4lAACwZegAALAMJgAAimUgAAFkB6UAAN+iiAATwrJ1ABULeTAAAISasAAB4OBgAABztfUA==
Date:   Wed, 7 Jun 2023 18:44:36 +0000
Message-ID: <BYAPR12MB33364B5EB908BF7239BB996BBD53A@BYAPR12MB3336.namprd12.prod.outlook.com>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
        <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
        <BYAPR12MB333685D98C43D5247BEA998EBD409@BYAPR12MB3336.namprd12.prod.outlook.com>
        <646d0892eadc3_afb77294cb@dwillia2-xfh.jf.intel.com.notmuch>
        <BYAPR12MB3336AB6A519C709DBEA75CB5BD419@BYAPR12MB3336.namprd12.prod.outlook.com>
        <646d8c76811cb_250e29456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
        <BN8PR12MB3330831F2E666E9BB1319E66BD419@BN8PR12MB3330.namprd12.prod.outlook.com>
        <646e7f96f33e2_33fb3294c1@dwillia2-xfh.jf.intel.com.notmuch>
        <BYAPR12MB3336F5ADDEDBB6245BC2B48DBD489@BYAPR12MB3336.namprd12.prod.outlook.com>
        <647f9d082eb30_142af82944e@dwillia2-xfh.jf.intel.com.notmuch>
        <BYAPR12MB3336E224E4B3DD50ABDA04B6BD53A@BYAPR12MB3336.namprd12.prod.outlook.com>
 <20230607161224.00004795@Huawei.com>
In-Reply-To: <20230607161224.00004795@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3336:EE_|DM8PR12MB5429:EE_
x-ms-office365-filtering-correlation-id: 6bb164dd-b919-45d8-9d33-08db67873e70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fQeoZkrqB3XW8IvamNDJs+OHdl0DWTH+3ZMIoupQmfgeF71wECFP2fhEDPEt9lkU9ezEECMH3v8dlR/2UuRts7GDiteAOU6U0EQGWAc3uJA4p5UMk7vn6vT/IZrkghcrxRIAjukP3H4hpT1LMbwXjVV/c6yLqccSJ4vdZXzXiM7TJA+Mtb4WjMrlh8R1jfVpuyc3Bc3kcgkJzK7TNP0b3AxPJb9EB+uHuV3sytuDb4Nu6z3aJ/yG0lJgvF/kWAIMBcUPmgAN3OvloGZT0p1Hs4T60+DUgs0HL6XOshSl0J9SxLOYgzg6GQS+qw8YqMi1QcABFJRH9jWqfrb2tiJjBi8Mv7fQV/pSTM9JCezzozxb58aE1LzbdUWumJMOZhEa96iWoZPWMfpMkmAytJCl91f5vV/h7RgGFWX9EfmcK6hYr5g75bqrwVxroavSmx8sIUt7lbc3pvi21e1gtfjvoZ7RcYyrswtbiaKrS7jN9414l8Qsh37lZVHBxCKq/Llpt+Px8PoZQ/q6dMCbRl8faMZ7YpR3H8CsFSmVOo31rj1WqbsH+vwUFYFToC3h7yXL/7wAF4gEcjeZGNiwsV4NN3ORaYViLdp345EpGOVM3aregF6yoxAuEODVL5m5l7Ot
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3336.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(6506007)(53546011)(26005)(9686003)(52536014)(83380400001)(122000001)(86362001)(2906002)(186003)(33656002)(316002)(55016003)(38070700005)(5660300002)(8676002)(8936002)(41300700001)(38100700002)(66476007)(6916009)(66556008)(76116006)(66446008)(4326008)(66946007)(54906003)(64756008)(478600001)(71200400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aBAWI2+vxdKHehiU0+36w5kPVTp/JxO0MDpWEKhHq5hD2ltA4HS/Mdl0D7vt?=
 =?us-ascii?Q?KhcOkxV5RumWhduVUXZt6OYnHxruBrKCTkcC1MAqtg062B/l5x7g+qw0crAm?=
 =?us-ascii?Q?th2Vl2lfZMBfGVe4Be3hlAm/2ZNYxGpDK7V7EhyU/SkV6tjwboOudtlSuP3G?=
 =?us-ascii?Q?F9XWGaqQJ2iQmbqqrE+7Fc+JpjLQvJgwn3iBYc3+qFUUTuhUs9MU16Dszh5x?=
 =?us-ascii?Q?MXbU1QXLVCNfyTCt7TXbx7jcTJz5m4I5lrH8CyFWnpyVwbw0EBTuHWoLNvkq?=
 =?us-ascii?Q?m0aSeJ1SgqdezWTvpLDjT4IDVb1ebsI+bsyG8sgS6SO3Hs9/fRPT6u7MjoUC?=
 =?us-ascii?Q?jh7mfT6VxRwaOyGJer3KlTdJmtKwkWy4fS9CE/vePjmqEzDI/YzOQPP8XN0D?=
 =?us-ascii?Q?16gWmsdZenatglyQk6LiN9sCezbPAWjtD4cKwrq4+Lry2fK4VTziP1V+tLmv?=
 =?us-ascii?Q?VPoohAQW7YCNcjTx8GwUXkjiMjSxujTiG9BY1IIlMkWCWT1yt59NbRioKOBR?=
 =?us-ascii?Q?4aYxyrL67tE8DFmLGz2Iq+wybmLoLWa1zH58ry5lRcg51SpFO9klTr638a+U?=
 =?us-ascii?Q?9bk/6PhOKEAVda/K/hhkK7z5f/OfMVgb7v882GJ1+wq+vqCJVnwj0MSrHoxS?=
 =?us-ascii?Q?7Mg87PCGn27VmrtAg99ktuKDhFvBUEAZCunuXKpwDKW1UyGgPE+mS+BxmfPS?=
 =?us-ascii?Q?NQuOL/+wH7oOI+gzpQ/yLsGnsix0OLRVaidllc8g3KxLiAsQ4VfHNKJ0acNs?=
 =?us-ascii?Q?7/RcdG7sbDJZNqtWFLqrSPTkK5TPSmAUsGPFGzaxdmxCZ3XA6ZCl9gqclsng?=
 =?us-ascii?Q?jGXkFVPWUD6P3GxJfn3/Wp08Lv2kOebZD6JjSstzL8i9Pi0ALhEfC9r9SPwL?=
 =?us-ascii?Q?be8I857S7uPrW6+sz8sSX2Oo3z6onqItaX1cYKzD3mO4yZJeTpue5R2u9g/4?=
 =?us-ascii?Q?UfYM6FLSlU3uesZca+/6I/nQHi10mWcBYLwB6EZr/hTiQr0RVeUGKQzIXZ3e?=
 =?us-ascii?Q?chOyWWarzP+NMqPA3XHVdCT6VbO+y2hYkAeDyJB+V2GT44BmODZfp5vBOuo4?=
 =?us-ascii?Q?EFJOP89HRNUoRO0m0J5X9XmFr8IX1wfFpyDVlTtx2pGWgYS/pOUpZmWiRvxG?=
 =?us-ascii?Q?FawKDZvBU2wmbHHCzAdE8MrLayBWa0lxiQP4PgRHK+h2EoHOmdeTk5GrsDfb?=
 =?us-ascii?Q?oIzLTmUO8C4w811OapS4dsnvCFGSpAdiL7MrzkaG2+IW7JqBUDHPe/144gk8?=
 =?us-ascii?Q?64bNZObUP4nsqJ4HcBJBWrS0xWRlDup486YXGK9V0y1jMcfWuqxTxmCs3pfh?=
 =?us-ascii?Q?GNiox61hmrme69i1WWPhG1/JXbh3PMM0s418vJ/dzJVoZslIKzyPEDayMQUc?=
 =?us-ascii?Q?+3luSukuxFoWzdAM04l+THGMb0jkzic6Flmz5QEwlAMWs9PiW8gUeh/BkL/Z?=
 =?us-ascii?Q?OL40z6VqpPHJh4iI73x9gD8XwcPsDP2rRUHKikMS7dulpw4rG0PZNarwQwuc?=
 =?us-ascii?Q?93n5+SPl9/B6V/HCcRm/rfuqAjCodCBaT77c1IAOmEH7MKfL4gMNVy8LnUV2?=
 =?us-ascii?Q?CSMAn6B6NW9iRQKw5Aw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb164dd-b919-45d8-9d33-08db67873e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 18:44:36.8437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TrDqF+xHWd0Xnubtl/fN9HHJtWbE3bbC295Wa+ugQ5LxhuVJ9MKWC5dEIgy3BOEwYi3n+Bu4jEn0WLUt1jXF8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Wednesday, June 7, 2023 10:12 AM
> To: Vikram Sethi <vsethi@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>; Yasunori Gotou (Fujitsu) <y-
> goto@fujitsu.com>; linux-cxl@vger.kernel.org; catalin.marinas@arm.com;
> James Morse <james.morse@arm.com>; Natu, Mahesh
> <mahesh.natu@intel.com>
> Subject: Re: Questions about CXL device (type 3 memory) hotplug
>=20
>=20
> On Wed, 7 Jun 2023 01:06:05 +0000
> Vikram Sethi <vsethi@nvidia.com> wrote:
>=20
> > > From: Dan Williams <dan.j.williams@intel.com>
> > > Sent: Tuesday, June 6, 2023 3:55 PM
> > > To: Vikram Sethi <vsethi@nvidia.com>; Dan Williams
> > > <dan.j.williams@intel.com>; Yasunori Gotou (Fujitsu)
> > > <y-goto@fujitsu.com>; linux-cxl@vger.kernel.org;
> > > catalin.marinas@arm.com; James Morse <james.morse@arm.com>
> > > Cc: Natu, Mahesh <mahesh.natu@intel.com>
> > > Subject: RE: Questions about CXL device (type 3 memory) hotplug
> > > Vikram Sethi wrote:
> > > > Hi Dan,
> > > > Apologies for the delayed response, was out for a few days.
> > > >
> > > > > From: Dan Williams <dan.j.williams@intel.com>
> > > > > Sent: Wednesday, May 24, 2023 4:20 PM
> > > > > To: Vikram Sethi <vsethi@nvidia.com>; Dan Williams
> > > > > <dan.j.williams@intel.com>; Yasunori Gotou (Fujitsu)
> > > > > <y-goto@fujitsu.com>; linux-cxl@vger.kernel.org;
> > > > > catalin.marinas@arm.com; James Morse <james.morse@arm.com>
> > > > > Cc: Natu, Mahesh <mahesh.natu@intel.com>
> > > > > Subject: RE: Questions about CXL device (type 3 memory) hotplug
> > > > > Vikram Sethi wrote:
> > > > > [..]
> > > > > > > I don't understand this failure mode. Accelerator is added,
> > > > > > > driver sets up an HDM decode range and triggers CPU cache
> > > > > > > invalidation before mapping the memory into page tables.
> > > > > > > Wouldn't the device, upon receiving an invalidation request,
> > > > > > > just snoop its caches and say
> > > > > "nothing for me to do"?
> > > > > >
> > > > > > Device's snoop filter is in a clean reset/power on state. It
> > > > > > is not tracking anything checked out by the host CPU/peer.
> > > > > > If it starts receiving writebacks or even CleanEvicts for its
> > > > > > memory,
> > > > >
> > > > > CleanEvict is a device-to-host request. We are talking about
> > > > > host-to-device requests which is only SnpData, SnpInv, and
> > > > > SnpCur,
> > > right?
> > > > >
> > > > I was referring to MemClnEvct which is a Host request to device
> > > > (M2S req) as captured in table C-3 of the latest specification
> > >
> > > Ok, thanks for that clarification.
> > >
> > > >
> > > > > > looks like an unexpected coherency message and i Know of at
> > > > > > least one implementation that triggers an error interrupt in
> > > > > > response. I don't know of a statement In the specification
> > > > > > that this is expected and implementations should ignore. If
> > > > > > there is such a statement, could you please point me to it?
> > > > >
> > > > > All the specification says (CXL 3.0 3.2.4.4 Host to Device
> > > > > Requests) is what to do *if* the device is holding that
> > > > > cacheline.
> > > > >
> > > > > If a device fails when it gets one of those requests when it
> > > > > does not hold a line then how can this work in the nominal case
> > > > > of the device not owning any random cacheline?
> > > >
> > > > I didn't understand. The line in question is owned by the device
> > > > (it is device memory). The device has just been CXL reset or
> > > > powered up and its snoop filter isn't tracking ANY of its lines as
> > > > checked out by the host. The host tells the device it is dropping
> > > > a line that the host had checked out (MemClnEvct) but per the
> > > > device the host never checked anything out. Seems perfectly
> > > > reasonable for the device to think it is an incorrect coherency
> > > > message and flag an error. What is the nominal case that you think
> > > > is broken?
> > >
> > > The case I was considering was a broadcast / anonymous invalidation
> > > event, but now I see that MemClnEvct implies that the line was
> > > previously in the Shared / Exclusive state, so now I see your point.
> > > The host will not send MemClnEvct in the scenario I was envisioning.
> > > > >
> > > > > > Remove memory needs a cache flush IMO, in a way that prevents
> > > > > > speculative fetches.  This can be done in kernel with
> > > > > > uncacheable mappings alone, if possible in the arch callback,
> > > > > > or via FW call.
> > > > >
> > > > > That assumes that the kernel owns all mappings. I worry about
> > > > > mappings that the kernel cannot see like x86 SMM. That's why
> > > > > it's currently an invalidate before next usage, but I am not
> > > > > opposed to also flushing on remove if the current solution is
> > > > > causing device-failures in
> > > practice.
> > > > >
> > > > > Can you confirm that the current kernel arrangement is causing
> > > > > failures in practice, or is this a theoretical concern? ...and
> > > > > if it is happening in practice do you have the example patch
> > > > > that fixes it?
> > > > Yes, it is causing error interrupts from the device around device
> > > > reset if the host caches are not flushed before the reset.  It is
> > > > currently being worked around via ACPI magic for the cache flush
> > > > then reset, but kernel aware handling of the flush seems more
> > > > appropriate for both hot plug and CXL reset (whether via direct
> > > > flush or via FW calls from arch callbacks).
> > >
> > > Makes sense, and yikes "ACPI magic". My concern though as you note
> > > above is the cache line immediately going back to the "Shared"
> > > state from speculation before the HDM decoder space is shutdown. It
> > > seems it would only be safe to invalidate sometime *after* all of
> > > the page tables and HDM decode has been torn down, and suppress any
> > > errors that result from unaccepted writes.
> >
> > I agree regarding cache flush after page table mappings removed, but
> > not sure that HDM decode tear down is a requirement to prevent
> > speculation. Are there architectures that can speculate to arbitrary
> > PA without any PTE mappings to those PA? Would
> cxl_region_decode_reset
> > be guaranteed to not have any page table mappings to the region and be
> > a suitable place to also flush for a CXL reset type scenario?
> > >
> > > I.e. would something like this solve the immediate problem? Or does
> > > the architecture need to have the address range mapped into tables
> > > and decode operational for the flush to succeed?
> >
>=20
> > The specific implementation does not require page table mappings to
> > flush caches. I'm not sure that simply suppressing error interrupts
> > for any writebacks or MemCleanEvict that happen after a device
> > insertion/reset is good enough as devices could view that as a
> > coherency error.
>=20
> If on an architecture that guarantees no clean write backs (or at least n=
one if
> they are ever visible - which should include this case) shouldn't be a pr=
oblem.
>=20
The clean drop notification (MakeCleanEvict) is sent to the device telling =
it that a clean line held by the CPU was dropped. That is the more common e=
rror condition as I agree that most architectures won't actually writeback =
a clean line.=20

> So who wants to point an laugh at anyone that does clean write backs that
> can be observed?
> :)
>=20
> Even on archs that do allow for such write backs, I believe they are not
> common as otherwise perf would be terrible: so just let the errors throug=
h -
> they are flagging errors in PAs that aren't mapped so should just generat=
e a
> small amount of noise in the logs.
>=20
> So flush before to make clean (or invalid but then potentially prefetched=
 so
> clean) - tear down the HDM decoders and flush again / invalidate so nothi=
ng
> stale hanging around (or do it before bringing something new up at that H=
ost
> PA). Eat or log any errors and don't worry about it.
>=20

I'm OK with this approach. When the cache flush is done at the time of the =
decoder tear down, there mustn't be any page table mappings to the decode H=
PA ranges (and if any ISA wanted to do an in kernel flush vs FW call, and n=
eeded a PTE mapping for the flush, that should be done with a non cacheable=
 mapping).

> Maybe I'm missing some corners cases.
>=20
> Jonathan
>=20
> > >
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 543c4499379e..60d1b5ecf936 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -187,6 +187,15 @@ static int cxl_region_decode_commit(struct
> > > cxl_region *cxlr)
> > >         struct cxl_region_params *p =3D &cxlr->params;
> > >         int i, rc =3D 0;
> > >
> > > +       /*
> > > +        * Before the new region goes active, and while the
> > > physical address
> > > +        * range is not mapped in any page tables invalidate any
> > > previous cached
> > > +        * lines in this physical address range.
> > > +        */
> > > +       rc =3D cxl_region_invalidate_memregion(cxlr);
> > > +       if (rc)
> > > +               return rc;
> > > +
> > >         for (i =3D 0; i < p->nr_targets; i++) {
> > >                 struct cxl_endpoint_decoder *cxled =3D p->targets[i];
> > >                 struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> > > @@ -3158,8 +3167,6 @@ static int cxl_region_probe(struct device
> > > *dev) goto out;
> > >         }
> > >
> > > -       rc =3D cxl_region_invalidate_memregion(cxlr);
> > > -
> > >         /*
> > >          * From this point on any path that changes the region's
> > > state away from
> > >          * CXL_CONFIG_COMMIT is also responsible for releasing the
> > > driver.
> >

