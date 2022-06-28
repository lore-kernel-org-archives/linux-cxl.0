Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C481C43334
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Jun 2022 15:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347927AbiF1Pec convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Jun 2022 11:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347897AbiF1Peb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Jun 2022 11:34:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2116.outbound.protection.outlook.com [40.107.94.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325862C65D
        for <linux-cxl@vger.kernel.org>; Tue, 28 Jun 2022 08:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGnPec8SSLT7B4J+iMBtRMJJjqGMtnwMkdu5NgGBRD/Aj0MCE9iGirI/OVg6RmSSOA0AWrvtlhOKw7keSBa/uMidqjSLcN8AlH2kv+3X6lX7wlyZ9JcbNgr153ZrYOexuEDZUePBYXyxn6n7xR57r/VBBdhY+yUVnfOE2psjKnsaB4raHXxQMZa1fPwcX3Djm9vLPg/cCUs541bo8Wlbs7ciJulvOZRdIKyEBlBE/WtD/bkSbwUYsdi+bfNmRcsK2PY/2/iUL11PdZc/lbMZPhQBOlyP1G2Tty0mheOLn2P2kFmizI6kNSY1hj41ikH93nQyuPHUcgAFoQTLQ2eoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9l5i6qh5aE+DkhGH67YbJZPPEhUohKPmNCTlVaLCrGU=;
 b=j5yGui8tIocmI5qWszdSZIeD5+5wUd1IosvhkeRe6q3MWEVFM8/AU1AVZ6FPcxV8OCr5Upn0ZRBaSvMXxnzviGZPWG1mU8MytEBWvwPix3xoGPR/drvzl/QmoCBROY8KVgqehkCOjZ5fF6hxJoBIrQdhFTEcK0IK79nAF3RjvNeQ/jH2rIbv6gY1yUZ2olafcQncMKvjxLAF7cpJA1SWnH3/S7v+b6qOz/nVKPyHgargwRFgDBQ8AkdyxFNj8ftx8M0zw6IkZY2IT6BMvrJcCbOFOWbhHEI8QjERLzg4Ldg/u4NOrxAROemM83cMnPrs7GQGSqkQRrgBbszU8bp5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elastics.cloud; dmarc=pass action=none
 header.from=elastics.cloud; dkim=pass header.d=elastics.cloud; arc=none
Received: from DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) by
 DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Tue, 28 Jun 2022 15:34:22 +0000
Received: from DS7PR12MB6007.namprd12.prod.outlook.com
 ([fe80::e9eb:55ac:62f3:f096]) by DS7PR12MB6007.namprd12.prod.outlook.com
 ([fe80::e9eb:55ac:62f3:f096%9]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 15:34:22 +0000
From:   Mani Subramaniyan <mani.subramaniyan@elastics.cloud>
To:     Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: DVSEC FLEX BUS CAP bit 3: MEM_HWINIT_MODE
Thread-Topic: DVSEC FLEX BUS CAP bit 3: MEM_HWINIT_MODE
Thread-Index: AdiJ62AvTeOmYwdPQKq/w7nxUnfXngAc3vSAACgB2qA=
Date:   Tue, 28 Jun 2022 15:34:22 +0000
Message-ID: <DS7PR12MB60077E9A94B20ADAEE883F109CB89@DS7PR12MB6007.namprd12.prod.outlook.com>
References: <DS7PR12MB60074C18A01B242F165F68009CB99@DS7PR12MB6007.namprd12.prod.outlook.com>
 <62ba0987bc7cf_1134f9294f0@dwillia2-xfh.notmuch>
In-Reply-To: <62ba0987bc7cf_1134f9294f0@dwillia2-xfh.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elastics.cloud;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 224afcee-5bcb-4f56-5b74-08da591bacb9
x-ms-traffictypediagnostic: DM5PR1201MB0203:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ok3+YSwsWoYjZIjM5NWxJ1F++gQWZdAYC8t3SuGVHh+1zhnZQz3XPv71kj3ezhU1nX/tLFsf/lXGa7PxkQ+WfLiI6LulogglBQ0/Emcd35FHitnk2nEzoXFaeN9xW/kv537JDp6fegqzUqqPu6IY/1Dafyl+GKi7UbACILPdDLdqKkfYTcTuLj1iBIN+H4c8ptyWicYqg8TIWScCMiP+m1MwUblW7Ljws7BB31wBHx5tvSSgdKCxTLUlCItP6e4jSTccN9+rCEGH2sMTBzksABqwP+veZuldSQaMmjcVMw71qSvK4iyvOER1p7WG/wX/iM6gjM+FyOGHW/Wcf6PP6ujRsZD7o9vRG5EDFSI5lO2ARdXRwBEb7MppXjy3QUPTfttxywIgrX5DCyTPLva1RMguTclitXm8JeM2aX5WDkS5yT6ykxy3U7QYDK1wAlKYWXu0Q5rpkfxHwiLmSYAj9LIImCN+a6psdlegyCljphZbznno+tfLkIMmnVDGbYIrhf5Rmi/Z0pnNhPzC7sMY7Yo55xVG1I80OqoE9m0KfEtv8j8/oBNyMXIoAPanYXVf75q69oZvCVV7eOIFxfvzGhhjMQkCV8uGMDwlg0pljSu7v1tOKj7yp7Ntuf/U95WtZkLBAq/cB4UxfYDuoEJ3XSLzq4+ln+uIsjWy5YG4qhs83BR8Kqa8fyq3ZIycsthhqzCpAVUYwzJwXnd1mKqsrp4DL45rUi5BlXsyKMMkzLr3B7sTDN4MG3sxjJ5Ge/AVGkrtbli5qKyyBgyxfp6jh4eJLs+VKxG6zj1GLuIdUXpyPIupneevm7ouTAwZ6EyBy3idDsN2hhlcUmWf/p/1Mw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6007.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39830400003)(396003)(366004)(346002)(376002)(38070700005)(64756008)(9686003)(86362001)(83380400001)(41300700001)(76116006)(186003)(316002)(66476007)(2906002)(8676002)(66556008)(66446008)(66946007)(38100700002)(122000001)(5660300002)(71200400001)(55016003)(478600001)(8936002)(966005)(6506007)(44832011)(52536014)(33656002)(7696005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e3KFNzv3c4O5Q992n11lb0E+faOIcJ5S8BX7Es5YSnXfg+8C4tJlPjXEd1BA?=
 =?us-ascii?Q?ILfThQ5sybRZnRi3paYGv+1ypHnr3V3xC0QtYUnzYN1hL+Kj+qJrQQj5RLsp?=
 =?us-ascii?Q?32/wgmeYkth3u5djEWRYRcnfcN64EEKQDJce3uLEjS8cAT9nOB+bB0RzE2yn?=
 =?us-ascii?Q?LPgvSLxog2sdCdVegGB4nU6xTwBu//vR1VnWtTALGraPnaYfgrG4DhfwKZNa?=
 =?us-ascii?Q?DSeA5CTr07Aq9x+mbV5FxvrSxV8YdxE0GMmmcfdjaYgksvDAbg6aBD9KjS4g?=
 =?us-ascii?Q?IAlOSvamMWO9uv9nzx9RtKpMix5f9EBTCsFnK4Z7g3SIEsqioq78TxMIYpKf?=
 =?us-ascii?Q?kTi9MN6ZI7tj9q9VuLkwJ17o+aKvhVNQgSYZMYzMAaMwkP+EQaCVDJX1s4cG?=
 =?us-ascii?Q?2ieY5Ds2M6L10Re3gdypFQT9wjMhO1pmYsfntOhoPzqT75b0nIYAIRdv33Tc?=
 =?us-ascii?Q?weCpUGI5lsE5xs6cjKMRm5/yV20Bw4UKjw0ry+lIMWtxrgNIG3rSme21inh+?=
 =?us-ascii?Q?r88J/N7c6ukAHxPta1gNMk08NSJ63AGc6ICqXYzUfvY32g8FgQXc+sP3MWmd?=
 =?us-ascii?Q?CMagDrlkpP9jfIqDzeD9DSjKnGJYbkwcr5GPBG4wa1dGDQXqooiYmIPGMlSs?=
 =?us-ascii?Q?doCuE9NLPAjzjlcxQErDWbAXhYQpEqMvHWS42F3p+xlqJq0vme9xBgD+4NEt?=
 =?us-ascii?Q?lTt3clfaAFlQGQiBp3mE9fqNOO0VZufTG1EbqIgM007cO7bw3oUOfNkpL9Ik?=
 =?us-ascii?Q?IgWwDFX4kg8g6pHcPbiHiSn7t0NoQDMXYZPIrjQjCmArcQJeLH4ACG1+iLPr?=
 =?us-ascii?Q?0Jx9ijEkMQ3lR6SYoD5JpNzMd74seOTVTPF92c46uZG4+v8EiAq/QvqA6y2I?=
 =?us-ascii?Q?x9EJOEoB8WSfGItEmU4fMib3MDH/ZtI5PReIPxdFEJEDi5jWpBkeXfdgzkPT?=
 =?us-ascii?Q?nLrKU7EHSS5hplHhQ/hXUGCFRZAPt16l0SEoU+bdOc7vghbgmrq8NDeW2rzp?=
 =?us-ascii?Q?9AvB7mWn5ZGt7HkX6NUpmiISt0Z6qaOOqhV2TpmSUFYMNcR0b4nCZhDz/Kdb?=
 =?us-ascii?Q?OnyTbyXOgOksBqITtbeJjo9P8+RQY9dnoXeXQXymCObyJh1DaCaP8Kh+zeTc?=
 =?us-ascii?Q?jaSHk5Kr2q5xnRvILClI90Hhab2b4NOr1Zs8BRCnsDWIyi2JJzTjoD5EZMvl?=
 =?us-ascii?Q?aUEWhSeGMsLs05HQr0k65XyegqtO1D/7cN+bn4xflcPtWGKcZLgIk1taLV2Q?=
 =?us-ascii?Q?xaZKnMpOpt7NoVHes+61tuI8/IcYmcYLe4zF+GlXBZ3hb87GGK4mH41aDe3X?=
 =?us-ascii?Q?Rr1zxQufTLgdd7dfx9TesUoRIRWZDhxscniBWmbV5Wwb/PL9MMC0TbOPAtBA?=
 =?us-ascii?Q?NK5o+VP2u2+kRpaqLEhNUShjD+LzgG2jjRfAbcwJ958KOiUViAVO155AvscW?=
 =?us-ascii?Q?hBfAeQV7mWzkeCml5EiQ0fWujYjeCZqOsW0rB1MKHmRXMLOS3g4oEK7cLRUk?=
 =?us-ascii?Q?9JAPv+XieYbKf/hZAp80/EkDEvqAps5zgVskj7WVYQ7E5Jc7xTbu3WlIF57L?=
 =?us-ascii?Q?ecpX9VyUv8cAj1EgRw+PCCxC2dkQnosrKsbtttNTiluaf8a+cOnk1G6S4tOn?=
 =?us-ascii?Q?YDrJ7yLvVr1RAWAqR7RdAanbA4CPtcxaQZFoUFkEB/bXUUF/jzFNT6yTPFYs?=
 =?us-ascii?Q?Hp80+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: elastics.cloud
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224afcee-5bcb-4f56-5b74-08da591bacb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 15:34:22.2539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 28558b47-528a-463d-9ef1-81068bcc77f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sV3YpIsoGS0vvB5RBmnfuN/zlS0063kkUeuBL5YTf27+ywirp9DhtRnLvXlY7NnXAnSfkQ//ZRWytINGr/dKKeT4cFUvtyZJC+R15abEsrKcR0hFyZBvi4+TAW8GK5Q9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks Dan for your answers!
As for MEM_HwInit_Mode, spec indicates that when it is set, hardware has to set memory active in the range low address bits within 100msec (it has to complete its internal initializations within that time).

This leads me to assume the following for a software initialization:
1. Both mem_hwinit_mode and mem_active are set to 0 by hardware.
2. OS loads a driver (either generic or vendor specific) that talks to the hardware and does the hardware initialization. Hardware, after completing the initialization, also changes the mem_active bit state to 1.
3. Software/driver checks the state of mem_active and then sets up that memory (either mmap for its own use or for system use).

You are right about the spec wording. Yes, driver cannot make this mem_active to change states, but the hardware completion of initialization should make the hardware change the state.

Some other replies/questions inline...

Thanks
ManiS

-----Original Message-----
From: Dan Williams <dan.j.williams@intel.com> 

Mani Subramaniyan wrote:
> While reading the CXL spec (both 1.1 and 2.0), of the DVSEC Flex bus 
> cap (offset 0ah, bit 3), I see this: "3 RO Mem_HwInit_Mode: If set, 
> indicates this CXL.mem capable device initializes memory with 
> assistance from hardware and firmware located on the device. If clear, 
> indicates memory is initialized by host software such as device 
> driver. This bit must be ignored if CXL.mem_Capable=0."

Hmm, to me the specification does not indicate how OS drivers can initialize memory in the MEM_HWINIT_MODE=0 case. It says impossible things like the following in "9.11.5 CXL 1.1 device discovery":

    The OS device driver is responsible for setting Memory_Active after
    memory initialization is complete. Any subsequent accesses to the HDM
    memory are decoded and routed to the local memory by the device.

...which is impossible because Memory_Active is an RO bit. So yes, you have discovered a gap in the Linux handling of the MEM_HWINIT_MODE=0 case, but I think it looks like a gap in the specification as well as what the OS can expect of memory readiness in that case.

ManiS: agree. The wording has to say that the hardware changes the value of mem_active to 1 when the initialization is complete and successful.

> 
> I figured that I would clear this bit so I can load my driver for the 
> CXL type 3 device and also reset the memory active bit in the HDM 
> entry (range low address bits). I was experimenting this on QEMU 
> version 6.0.50 from Ben Widawsky (branch cxl2v4-doe), running an 
> Ubuntu 64 bit Kernel ver 5.18.0.rc7.  Here is what I see in dmesg
> output: 
> [   62.234755] cxl_pci 0000:09:00.0: timeout awaiting memory active after 60 seconds
> [   62.235793] cxl_mem mem0: Media not active (-110)
> [   62.236447] cxl_mem: probe of mem0 failed with error -110
> [  123.674758] cxl_pci 0000:09:00.0: timeout awaiting memory active 
> after 60 seconds [  123.675800] cxl_mem mem0: Media not active (-110) 
> [  123.676450] cxl_mem: probe of mem0 failed with error -110
> 
> In spite of these error messages, I could use the CXL memory without any issues!

Sure, the driver has no role to play if something else has already programmed the HDM decoders.

> My purpose is to load my driver on this device and then initialize and 
> bring the memory on line or use the memory for my own software not 
> giving it to general memory pool of Linux.

This is a flow that the native Linux driver will support. Memory will be assigned to the device-dax subsystem. From there it can either remain dedicated access through a device special file, or optionally shared with the general Linux memory pool. See the "persistent reconfiguration"
section of this man page for examples of what this policy might look like (i.e. it's still a work in progress):

https://github.com/pmem/ndctl/blob/main/Documentation/daxctl/daxctl-reconfigure-device.txt#L244

ManiS: Thanks for the link. Yes, that may work for my purpose.  
> 
> Since I am new to this alias, and not following the threads fully (did 
> do a search though), can someone point me in the right 
> direction/clues?
> 
> My questions are:
> 1.	Shouldn't the Linux CXL code have looked at the MEM_HWINIT_MODE
> bit first and if that is not set, should not have complained about 
> this mem active bit, assuming that the software/driver will initialize 
> and then make the memory active at a later time ?

Perhaps, if there is clarity about the OS responsibilities in the
MEM_HWINIT_MODE=0 case.

ManiS: Agree.  I am interpreting based on an extrapolation of init_mode=1 spec.

> 2.	If a vendor driver loads,

For generic memory devices expander device why is a vendor driver in the picture? For accelerators the expectation is that they can use some of the core CXL infrastructure to manage HDM, but we (upstream Linux community), are still awaiting the first use case to take advantage of those core APIs.

> talks to the hardware to initialize and make the hardware change the 
> memory active bit state, how does the vendor driver, if it wants to, 
> gives the memory back to the kernel? Should there be a kernel call for 
> that purpose or this is very similar to dax initialization and so 
> there is no further need for a kernel call?

It's very similar to dax to the point that the shortest path to get what you want is just use dax and the generic driver, unless I am missing a reason why that is not possible?

ManiS: Yes, device dax is enough for most purposes. I can't think of a usage where we need anything more at this point. Thanks!
