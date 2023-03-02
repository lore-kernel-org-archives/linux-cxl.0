Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DB1C678D4
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Mar 2023 10:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjCBKz7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Mar 2023 05:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCBKz6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Mar 2023 05:55:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BA13CE07
        for <linux-cxl@vger.kernel.org>; Thu,  2 Mar 2023 02:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677754510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HsZKqPyXmkcDK+HT2f/lQGqJ4IpXfDJksnmqf9kYf3s=;
        b=SrYpDCJCgjOl9hFUAHVKqr3+PSScLLxhkqSjpCKCVZ0gPedHSvX+nBMnd5aBMzj2qd/+eQ
        IB+guNUYPF2STRm3y94yUTw+Mcn/kRVl2Xm/k1y8cTWkVA0f4njLFT4NBKqLzrzLfhawCq
        vI4bErEEMQYEqisBOfdYnitnNRhpDoc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-315-mlVQNjcNMGuOenpL7UI7LQ-1; Thu, 02 Mar 2023 05:55:06 -0500
X-MC-Unique: mlVQNjcNMGuOenpL7UI7LQ-1
Received: by mail-wm1-f69.google.com with SMTP id 4-20020a05600c024400b003eb2e295c05so5619606wmj.0
        for <linux-cxl@vger.kernel.org>; Thu, 02 Mar 2023 02:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677754505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsZKqPyXmkcDK+HT2f/lQGqJ4IpXfDJksnmqf9kYf3s=;
        b=izmELFtwP6KQypLBTRFRC4DCagUG2DBWuOIbbYRg7u49B8u6h211YW74pheaHbXpD1
         lgHC1EaT9jjW/SQq2lVWFDVA/ysPTCl27gP9TOd56+OuwdrEIr89zxXxrCzpdB31xK0X
         etZWDBVEwbBBiC8PwAdTWk0DHfn44SLTu8cLh/SP5+XgB5lN6OWwgS1PHboRyXVvYTQF
         1UgNU6+JhgE92lY6rurvQgUNEyzk4AAjzQGxir/olmPkX+mD+BLOpUwQ/uTgWcPB/On9
         kP3ZVNMgeQTZbxBR/SQ9o0a8XysC05OxvGnQdG45jNUeCENiQRtXvQ1OgQflVfFlraK8
         BqUA==
X-Gm-Message-State: AO0yUKWQgzlxo5lEFP6RTlc1x8Dfy1YmosuVva4mx+Ru8lnRrXNox3yF
        A7mQrTDRT6TqmhVTKMlJkhbMlReNWskS+FhUDJwlTViJRrLcq//RFPbkrPZWOrWZKofFi9Kfl1G
        xPu17iY783IY7eW+vp8iv
X-Received: by 2002:adf:e490:0:b0:2c5:52b7:af88 with SMTP id i16-20020adfe490000000b002c552b7af88mr7506256wrm.36.1677754505771;
        Thu, 02 Mar 2023 02:55:05 -0800 (PST)
X-Google-Smtp-Source: AK7set9Bz1ETeVLbkAgoJhRoz5X1b26yvRxTkNJ7YTYQJ5Ast6MnrsN3KSMBzTepCps+Tcl7yOcyJw==
X-Received: by 2002:adf:e490:0:b0:2c5:52b7:af88 with SMTP id i16-20020adfe490000000b002c552b7af88mr7506241wrm.36.1677754505469;
        Thu, 02 Mar 2023 02:55:05 -0800 (PST)
Received: from redhat.com ([2.52.141.194])
        by smtp.gmail.com with ESMTPSA id y1-20020adfdf01000000b002c6d0462163sm15069232wrl.100.2023.03.02.02.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 02:55:04 -0800 (PST)
Date:   Thu, 2 Mar 2023 05:55:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu <qemu-devel@nongnu.org>, Ben Widawsky <bwidawsk@kernel.org>,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v6 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
Message-ID: <20230302055254-mutt-send-email-mst@kernel.org>
References: <20230227112751.6101-1-Jonathan.Cameron@huawei.com>
 <20230227112751.6101-9-Jonathan.Cameron@huawei.com>
 <20230302100608.00005bcd@huawei.com>
 <e9287de7-94a6-944b-1627-3fa8f7f1a9bc@linaro.org>
MIME-Version: 1.0
In-Reply-To: <e9287de7-94a6-944b-1627-3fa8f7f1a9bc@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 02, 2023 at 11:49:52AM +0100, Philippe Mathieu-Daudé wrote:
> On 2/3/23 11:06, Jonathan Cameron wrote:
> > +CC Michael Roth.
> > 
> > Michael Tsirkin noted I'd missed CCing QAPI maintaintainers on the
> > poison injection series so I went back to check the others I had out for review.
> > For this series I'd managed to pick up one of two as Markus gave comments on
> > earlier versions.
> 
> Now LGTM for meson/QAPI (although I'm not a QAPI maintainer).
> 
> Hopefully MST can take your series just in time for soft freeze.


Bottleneck is QAPI right now. Consider CC Eric and maybe Daniel
because Daniel is awesome and has been helping out with lots
of stuff among them QAPI.

> > On Mon, 27 Feb 2023 11:27:51 +0000
> > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > 
> > > CXL uses PCI AER Internal errors to signal to the host that an error has
> > > occurred. The host can then read more detailed status from the CXL RAS
> > > capability.
> > > 
> > > For uncorrectable errors: support multiple injection in one operation
> > > as this is needed to reliably test multiple header logging support in an
> > > OS. The equivalent feature doesn't exist for correctable errors, so only
> > > one error need be injected at a time.
> > > 
> > > Note:
> > >   - Header content needs to be manually specified in a fashion that
> > >     matches the specification for what can be in the header for each
> > >     error type.
> > > 
> > > Injection via QMP:
> > > { "execute": "qmp_capabilities" }
> > > ...
> > > { "execute": "cxl-inject-uncorrectable-errors",
> > >    "arguments": {
> > >      "path": "/machine/peripheral/cxl-pmem0",
> > >      "errors": [
> > >          {
> > >              "type": "cache-address-parity",
> > >              "header": [ 3, 4]
> > >          },
> > >          {
> > >              "type": "cache-data-parity",
> > >              "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
> > >          },
> > >          {
> > >              "type": "internal",
> > >              "header": [ 1, 2, 4]
> > >          }
> > >          ]
> > >    }}
> > > ...
> > > { "execute": "cxl-inject-correctable-error",
> > >      "arguments": {
> > >          "path": "/machine/peripheral/cxl-pmem0",
> > >          "type": "physical"
> > >      } }
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > > v6: (Thanks to Philippe Mathieu-Daudé)
> > > - Add Since entries in cxl.json
> > > - Add error prints in the stub functions so that if they are called without
> > >    CONFIG_CXL_MEM_DEVICE then we get a useful print rather than just silently
> > >    eating them.
> > > ---
> > >   hw/cxl/cxl-component-utils.c   |   4 +-
> > >   hw/mem/cxl_type3.c             | 281 +++++++++++++++++++++++++++++++++
> > >   hw/mem/cxl_type3_stubs.c       |  17 ++
> > >   hw/mem/meson.build             |   2 +
> > >   include/hw/cxl/cxl_component.h |  26 +++
> > >   include/hw/cxl/cxl_device.h    |  11 ++
> > >   qapi/cxl.json                  | 128 +++++++++++++++
> > >   qapi/meson.build               |   1 +
> > >   qapi/qapi-schema.json          |   1 +
> > >   9 files changed, 470 insertions(+), 1 deletion(-)

