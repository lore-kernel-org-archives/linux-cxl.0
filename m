Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417C5C7EE32
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Mar 2023 17:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjCBRXA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Mar 2023 12:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjCBRW6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Mar 2023 12:22:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168FA7292
        for <linux-cxl@vger.kernel.org>; Thu,  2 Mar 2023 09:22:55 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PSHqR4cvYz6J7f6;
        Fri,  3 Mar 2023 01:17:55 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 2 Mar
 2023 17:22:53 +0000
Date:   Thu, 2 Mar 2023 17:22:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        qemu <qemu-devel@nongnu.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        "Mike Maslenkin" <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v6 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
Message-ID: <20230302172252.00000025@huawei.com>
In-Reply-To: <20230302055254-mutt-send-email-mst@kernel.org>
References: <20230227112751.6101-1-Jonathan.Cameron@huawei.com>
        <20230227112751.6101-9-Jonathan.Cameron@huawei.com>
        <20230302100608.00005bcd@huawei.com>
        <e9287de7-94a6-944b-1627-3fa8f7f1a9bc@linaro.org>
        <20230302055254-mutt-send-email-mst@kernel.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 2 Mar 2023 05:55:00 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Mar 02, 2023 at 11:49:52AM +0100, Philippe Mathieu-Daudé wrote:
> > On 2/3/23 11:06, Jonathan Cameron wrote:  
> > > +CC Michael Roth.
> > > 
> > > Michael Tsirkin noted I'd missed CCing QAPI maintaintainers on the
> > > poison injection series so I went back to check the others I had out for review.
> > > For this series I'd managed to pick up one of two as Markus gave comments on
> > > earlier versions.  
> > 
> > Now LGTM for meson/QAPI (although I'm not a QAPI maintainer).
> > 
> > Hopefully MST can take your series just in time for soft freeze.  
> 
> 
> Bottleneck is QAPI right now. Consider CC Eric and maybe Daniel
> because Daniel is awesome and has been helping out with lots
> of stuff among them QAPI.

Thanks for the tip.  Resent with additional CCs (hopefully to right
people!) and a note that we are looking for qapi review.

With the benefit of hindsight I'd have ordered the series differently
if I'd guessed we'd bottleneck here.

Jonathan

> 
> > > On Mon, 27 Feb 2023 11:27:51 +0000
> > > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > >   
> > > > CXL uses PCI AER Internal errors to signal to the host that an error has
> > > > occurred. The host can then read more detailed status from the CXL RAS
> > > > capability.
> > > > 
> > > > For uncorrectable errors: support multiple injection in one operation
> > > > as this is needed to reliably test multiple header logging support in an
> > > > OS. The equivalent feature doesn't exist for correctable errors, so only
> > > > one error need be injected at a time.
> > > > 
> > > > Note:
> > > >   - Header content needs to be manually specified in a fashion that
> > > >     matches the specification for what can be in the header for each
> > > >     error type.
> > > > 
> > > > Injection via QMP:
> > > > { "execute": "qmp_capabilities" }
> > > > ...
> > > > { "execute": "cxl-inject-uncorrectable-errors",
> > > >    "arguments": {
> > > >      "path": "/machine/peripheral/cxl-pmem0",
> > > >      "errors": [
> > > >          {
> > > >              "type": "cache-address-parity",
> > > >              "header": [ 3, 4]
> > > >          },
> > > >          {
> > > >              "type": "cache-data-parity",
> > > >              "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
> > > >          },
> > > >          {
> > > >              "type": "internal",
> > > >              "header": [ 1, 2, 4]
> > > >          }
> > > >          ]
> > > >    }}
> > > > ...
> > > > { "execute": "cxl-inject-correctable-error",
> > > >      "arguments": {
> > > >          "path": "/machine/peripheral/cxl-pmem0",
> > > >          "type": "physical"
> > > >      } }
> > > > 
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > ---
> > > > v6: (Thanks to Philippe Mathieu-Daudé)
> > > > - Add Since entries in cxl.json
> > > > - Add error prints in the stub functions so that if they are called without
> > > >    CONFIG_CXL_MEM_DEVICE then we get a useful print rather than just silently
> > > >    eating them.
> > > > ---
> > > >   hw/cxl/cxl-component-utils.c   |   4 +-
> > > >   hw/mem/cxl_type3.c             | 281 +++++++++++++++++++++++++++++++++
> > > >   hw/mem/cxl_type3_stubs.c       |  17 ++
> > > >   hw/mem/meson.build             |   2 +
> > > >   include/hw/cxl/cxl_component.h |  26 +++
> > > >   include/hw/cxl/cxl_device.h    |  11 ++
> > > >   qapi/cxl.json                  | 128 +++++++++++++++
> > > >   qapi/meson.build               |   1 +
> > > >   qapi/qapi-schema.json          |   1 +
> > > >   9 files changed, 470 insertions(+), 1 deletion(-)  
> 

