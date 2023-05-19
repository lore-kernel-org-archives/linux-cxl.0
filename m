Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA46C7EE2A
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 15:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjESPpi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 11:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjESPpi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 11:45:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE5B1B4
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 08:45:36 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QN9zs3769z6J77x;
        Fri, 19 May 2023 23:41:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 19 May
 2023 16:45:33 +0100
Date:   Fri, 19 May 2023 16:45:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, "Ira Weiny" <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH v6 6/7] hw/cxl/events: Add injection of DRAM events
Message-ID: <20230519164533.0000436d@Huawei.com>
In-Reply-To: <6dc139cc-ec19-196f-017a-cb0a415af3e5@linaro.org>
References: <20230519143043.30191-1-Jonathan.Cameron@huawei.com>
        <20230519143043.30191-7-Jonathan.Cameron@huawei.com>
        <6dc139cc-ec19-196f-017a-cb0a415af3e5@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 19 May 2023 17:34:20 +0200
Philippe Mathieu-Daudé <philmd@linaro.org> wrote:

> Hi Jonathan,
> 
> On 19/5/23 16:30, Jonathan Cameron wrote:
> > Defined in CXL r3.0 8.2.9.2.1.2 DRAM Event Record, this event
> > provides information related to DRAM devices.
> > 
> > Example injection command in QMP:
> > 
> > { "execute": "cxl-inject-dram-event",
> >      "arguments": {
> >          "path": "/machine/peripheral/cxl-mem0",
> >          "log": "informational",
> >          "flags": 1,
> >          "physaddr": 1000,
> >          "descriptor": 3,
> >          "type": 3,
> >          "transaction-type": 192,
> >          "channel": 3,
> >          "rank": 17,
> >          "nibble-mask": 37421234,
> >          "bank-group": 7,
> >          "bank": 11,
> >          "row": 2,
> >          "column": 77,
> >          "correction-mask": [33, 44, 55,66]
> >      }}
> > 
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   hw/mem/cxl_type3.c          | 116 ++++++++++++++++++++++++++++++++++++
> >   hw/mem/cxl_type3_stubs.c    |  13 ++++
> >   include/hw/cxl/cxl_events.h |  23 +++++++
> >   qapi/cxl.json               |  35 +++++++++++
> >   4 files changed, 187 insertions(+)  
> 
> 
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 7e1e6257ce..5e82097e76 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -55,6 +55,41 @@
> >               '*device': 'uint32', '*component-id': 'str'
> >               }}
> >   
> > +##
> > +# @cxl-inject-dram-event:
> > +#
> > +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2)
> > +# This event type is reported via one of the event logs specified via
> > +# the log parameter.
> > +#
> > +# @path: CXL type 3 device canonical QOM path
> > +# @log: Event Log to add the event to
> > +# @flags: header flags
> > +# @physaddr: Physical Address  
> 
> Could this be a clearer description?
> 
> "Physical Address (relative to @path device)"

Makes sense.

> 
> > +# @descriptor: Descriptor
> > +# @type: Type
> > +# @transaction-type: Transaction Type
> > +# @channel: Channel
> > +# @rank: Rank
> > +# @nibble-mask: Identify one or more nibbles that the error affects  
> 
> > +# @bank-group: Bank group
> > +# @bank: Bank
> > +# @row: Row
> > +# @column: Column  
> 
> Why do we need bank/raw/col if we have physaddr?

Yes we need them. We don't know the device geometry / internal interleaving
/ address hashing applied to smooth out access patterns etc.

I really don't want to put that level of complexity into the command
line for a device - so just left it to the test tools to squirt in
something valid.

> 
> These are optional. Shouldn't we check they are valid
> in qmp_cxl_inject_dram_event()? (No clue, just wondering
> if there is some duplication here).

Validation is really hard for these as depends on the above
device implementation complexity.  There is a note on trying to
strike the balance in the cover letter. I'm not sure I have it
right! They are optional in records coming from the device, so
we set validity flags for them in the device record.

Aim here is to be able to inject whatever might be seen on a real device
without having to have QEMU emulate a bunch of device internals
such as mappings to particular DRAM FRU, chip, column, row etc.


> 
> > +# @correction-mask: Bits within each nibble. Used in order of bits set
> > +#                   in the nibble-mask.  Up to 4 nibbles may be covered.
> > +#
> > +# Since: 8.1
> > +##
> > +{ 'command': 'cxl-inject-dram-event',
> > +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> > +            'physaddr': 'uint64', 'descriptor': 'uint8',
> > +            'type': 'uint8', 'transaction-type': 'uint8',
> > +            '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
> > +            '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> > +            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
> > +           }}
> > +
> >   ##
> >   # @cxl-inject-poison:
> >   #  
> 

