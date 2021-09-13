Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4FEC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 19:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D099660EFF
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 19:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbhIMTJk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbhIMTJj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 13 Sep 2021 15:09:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61F9C061574
        for <linux-cxl@vger.kernel.org>; Mon, 13 Sep 2021 12:08:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id bb10so6497739plb.2
        for <linux-cxl@vger.kernel.org>; Mon, 13 Sep 2021 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3aBo5EQO69ZdaF/zllA4U1Fc6G7qpLrCOkgp/NaOZRY=;
        b=M2/15MzfiI79HSN0dun6YtRYA0bmnlSZsg4uhETWx2dHxithrU1lPHIaGzSD/lbTa0
         UQ91VJrumz5euilHzTREs6M1RNAMaTIzonPa1HhoZhPMexK6eg9FPHbgMku8k5Hatjqa
         GkaqKxCbEr84sCYCH5oUodatzm93VQk6iV/Jfz16x5CO27JRqR+32MHYRtyBz6QoafDj
         YIVUnwDCGtY2hN3OMymDVKD9RCCtSkgoQjpi4ONAU1p+TaF5pskmqdqDqyA/yUl7YzpQ
         QNqVqurl1Mz966NnkxfAQwmkvw5LA/1i2u2xQMkWv7P81cl5NA+BZaJQ7WPjDgy2lzo4
         VY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aBo5EQO69ZdaF/zllA4U1Fc6G7qpLrCOkgp/NaOZRY=;
        b=45GQ5prHXwJMsLX/jNTs0QApiN6aZVIw3LozAhMiYHqPm0QVg4k95OJYrFmlGJuYfS
         sUTZD0UFam7CfDvn20C7I7c3/fBTPpT5cIXyqYFU+fdFjsz1dxgY1AXm3gtsOazr4R7N
         MK+SPYBmO068jGvBzmdW+++0x20ggai0mWSabBSF1BmSg5DZluMbE/Zw9J3VCoxcLMV9
         1yOyGvvmaGjhG+Gntxn2DJHam39m0Sp1ntYxL1mwOVzVsQTsz+DmvQ/+r9l6Iab9sY/V
         RsEUX9vh9Y5EJmusZTP1DqxzgsrTtSGwWwBjwU+O3mm2M6scODTWeXU2zfOkJtKvGtiF
         hzTA==
X-Gm-Message-State: AOAM5332F5jmyXxmqnLEHCv9/4gmGz+oRi6Py7xXmp817TaadCjyxD0U
        6EIVwvyOXTf8+goesKcqmzQqyLTFIKKZO4CrrjBRCXVrv++Nmw==
X-Google-Smtp-Source: ABdhPJzehWTzOtj0O+2Z4UliWEy+A9fkF368p9FDU5TYwVO52IVRu73VzoN+JLAKctz0yZXDspv5W2u47GixKE52hOA=
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr1189346pju.8.1631560103175;
 Mon, 13 Sep 2021 12:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <YT9kSHU+P5wrnm2S@BigDog.local> <CAPcyv4gY7UvT7fkCcvxGwe7-s6r40rFExwLN2oc7xBtMGdRyAw@mail.gmail.com>
 <0100017bdf9fcce1-400920ad-2274-4d39-b45e-45410426db50-000000@email.amazonses.com>
In-Reply-To: <0100017bdf9fcce1-400920ad-2274-4d39-b45e-45410426db50-000000@email.amazonses.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Sep 2021 12:08:12 -0700
Message-ID: <CAPcyv4hjD=1EEAkjx+r3DRxASCGpF45kOyOZVULsMDekyG6TYQ@mail.gmail.com>
Subject: Re: CXL 1.1 Support Plan
To:     john@jagalactic.com
Cc:     johnny <johnny.li@montage-tech.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        John Groves <jgroves@micron.com>
Content-Type: multipart/mixed; boundary="0000000000006155df05cbe53009"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

--0000000000006155df05cbe53009
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 13, 2021 at 7:46 AM John Groves <john@jagalactic.com> wrote:
>
> On Tue, Aug 10, 2021 at 8:21 AM Dan Williams <Dan.J.Willaims@intel.com> wrote:
> > On Tue, Aug 10, 2021 at 5:24 AM johnny <johnny.li@montage-tech.com> wrote:
> > >
> > Hello,
> > >
> > > Current CXL patches [1] focus on CXL 2.0 support. While in the real world,
> > > CXL 1.1 capable host and EP are the first CXL components end user can use. May I
> > > ask community plan on CXL 1.1 support
> >
> > The expectation is that CXL 1.1 is BIOS / platform-firmware supported.
> > Just like the OS does not have a driver for DDR and relies on the BIOS
> > to describe DDR resources via generic ACPI tables, the same
> > expectation holds for CXL 1.1. CXL 2.0 explicitly adds features that
> > exceed what platform-firmware can support with static ACPI tables.
> >
> > Something is broken if the OS requires a driver for CXL 1.1 device
> > operation, at least for the generic memory expander use case.
> >
> > Ben did have some improvements to lspci to dump the range registers of
> > a CXL 1.1 device:
> >
> > https://github.com/pciutils/pciutils/pull/59
> >
> > ...but it does not seem the pciutils project has accepted that work.
>
> To probe a bit further here... On a system with a cxl 1.1 memory device,
> we see that bios maps it, but even though there is an SRAT entry
> describing a new NUMA node containing the cxl 1.1 memory, the memory
> shows up as "soft reserved" in the e820 memory map. And we observe
> that Linux (5.13 ATM) does not use it.
>

Looks like I need to improve the documentation here, please review the
attached patch and let me know if it answers your concerns.

In short, Linux *does* use it. Soft-reserve memory is accessed through
a dedicated device-file interface called device-dax by default. You
should be able to run:

cat /proc/iomem | grep dax

...and see your address range. I.e. something like:

# cat /proc/iomem | grep dax
    340000000-43fffffff : dax0.0

...and then /dev/dax0.0 can be directly accessed via mmap() (subject
to device-dax's strict mapping alignment restriction (default 2MB)).


> We can map the memory via /dev/mem (with CONFIG_STRICT_DEVMEM off), so
> we are able to hack tests & benchmarks to use the memory - but clearly
> this is not the correct or "intended" way to use cxl 1.1 memory.

Yeah, /dev/mem is superseded by device-dax for dedicated access and is
not recommended for CXL memory access.

>
> We could certainly add memmap=offset!size to the kernel command line to
> get it treated like simulated nvdimm - which is great if 1) the memory
> is non-volatile, and 2) it's reliably always at the same address (which
> it appears to be, but that feels like a bit of a squirrely outright
> assumption).

Correct, the BIOS is within its rights to move the location of that
memory from one-boot to the next. This is unlikely in typical
situations, but hardware removal or failure can cause the address map
to change from one boot to the next.

However, as mentioned in the attached patch you can simply ask Linux
to ignore the BIOS soft-reservation request (efi=nosoftreserve) if you
want all of that memory to be handed to the OS page allocator as
typical memory. Alternatively, if you only want a subset of the memory
to be given to the OS and the rest to remain dedicated access via
/dev/dax, then you can subdivide the dax range into multiple devices
and use 'daxctl reconfigure-device' to assign that slice of memory to
the OS page allocator.

>
> How are people thinking we'll map and use cxl 1.1 pmem?  And what about
> cxl 1.1 dram? Is the current Linux behavior considered adequate
> (ignoring the memory unless you use memmap, or efi_fake_mem)?
>
> ...or am I missing something?

Hopefully the attached document clears that up a bit, but let me know
what else is missing in the description.

--0000000000006155df05cbe53009
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-daxctl-Add-Soft-Reservation-theory-of-operation.patch"
Content-Disposition: attachment; 
	filename="0001-daxctl-Add-Soft-Reservation-theory-of-operation.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ktj0nvor0>
X-Attachment-Id: f_ktj0nvor0

RnJvbSAyYmNjOWJkMmU1NzUxMDYwOTc3ZjJiYzFlYThiYjRkNzRlYzNmMjZkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNv
bT4KRGF0ZTogV2VkLCAyNiBNYXkgMjAyMSAxMjoyMToxMiAtMDcwMApTdWJqZWN0OiBbUEFUQ0hd
IGRheGN0bDogQWRkICJTb2Z0IFJlc2VydmF0aW9uIiB0aGVvcnkgb2Ygb3BlcmF0aW9uCgpBcyBz
eXN0ZW1zIGFyZSBzdGFydGluZyB0byBzaGlwIG1lbW9yeSB3aXRoIHRoZSBFRkkgIlNwZWNpYWwg
UHVycG9zZSIKYXR0cmlidXRlIHRoYXQgTGludXggb3B0aW9uYWxseSB0dXJucyBpbnRvICJTb2Z0
IFJlc2VydmVkIiByYW5nZXMgb25lIG9mCnRoZSBpbW1lZGlhdGUgZmlyc3QgcXVlc3Rpb25zIGlz
ICJ3aGVyZSBpcyBteSBzcGVjaWFsIG1lbW9yeSwgYW5kIGhvdyBkbwphY2Nlc3MgaXQiLiBBZGQg
c29tZSBkb2N1bWVudGF0aW9uIHRvIGV4cGxhaW4gdGhlIGRlZmF1bHQgYmVoYXZpb3VyIG9mCiJT
b2Z0IFJlc2VydmVkIi4KClNpZ25lZC1vZmYtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlh
bXNAaW50ZWwuY29tPgotLS0KIC4uLi9kYXhjdGwvZGF4Y3RsLXJlY29uZmlndXJlLWRldmljZS50
eHQgICAgICB8IDEyNyArKysrKysrKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA4OCBpbnNl
cnRpb25zKCspLCAzOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rh
eGN0bC9kYXhjdGwtcmVjb25maWd1cmUtZGV2aWNlLnR4dCBiL0RvY3VtZW50YXRpb24vZGF4Y3Rs
L2RheGN0bC1yZWNvbmZpZ3VyZS1kZXZpY2UudHh0CmluZGV4IGYxMTJiM2M2MTIwZi4uMTMyNjg0
YzE5M2YwIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2RheGN0bC9kYXhjdGwtcmVjb25maWd1
cmUtZGV2aWNlLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL2RheGN0bC9kYXhjdGwtcmVjb25maWd1
cmUtZGV2aWNlLnR4dApAQCAtMTIsNiArMTIsOTQgQEAgU1lOT1BTSVMKIFt2ZXJzZV0KICdkYXhj
dGwgcmVjb25maWd1cmUtZGV2aWNlJyA8ZGF4MC4wPiBbPGRheDEuMD4uLi48ZGF4WS5aPl0gWzxv
cHRpb25zPl0KIAorREVTQ1JJUFRJT04KKy0tLS0tLS0tLS0tCisKK1JlY29uZmlndXJlIHRoZSBv
cGVyYXRpb25hbCBtb2RlIG9mIGEgZGF4IGRldmljZS4gVGhpcyBjYW4gYmUgdXNlZCB0byBjb252
ZXJ0CithIHJlZ3VsYXIgJ2RldmRheCcgbW9kZSBkZXZpY2UgdG8gdGhlICdzeXN0ZW0tcmFtJyBt
b2RlIHdoaWNoIGFycmFuZ2VzIGZvciB0aGUKK2RheCByYW5nZSB0byBiZSBob3QtcGx1Z2dlZCBp
bnRvIHRoZSBzeXN0ZW0gYXMgcmVndWxhciBtZW1vcnkuCisKK05PVEU6IFRoaXMgaXMgYSBkZXN0
cnVjdGl2ZSBvcGVyYXRpb24uIEFueSBkYXRhIG9uIHRoZSBkYXggZGV2aWNlICp3aWxsKiBiZQor
bG9zdC4KKworTk9URTogRGV2aWNlIHJlY29uZmlndXJhdGlvbiBkZXBlbmRzIG9uIHRoZSBkYXgt
YnVzIGRldmljZSBtb2RlbC4gU2VlCitsaW5rZGF4Y3RsOmRheGN0bC1taWdyYXRlLWRldmljZS1t
b2RlbFsxXSBmb3IgbW9yZSBpbmZvcm1hdGlvbi4gSWYgZGF4LWNsYXNzIGlzCitpbiB1c2UgKHZp
YSB0aGUgZGF4X3BtZW1fY29tcGF0IGRyaXZlciksIHRoZSByZWNvbmZpZ3VyYXRpb24gd2lsbCBm
YWlsIHdpdGggYW4KK2Vycm9yIHN1Y2ggYXMgdGhlIGZvbGxvd2luZzoKKy0tLS0KKyMgZGF4Y3Rs
IHJlY29uZmlndXJlLWRldmljZSAtLW1vZGU9c3lzdGVtLXJhbSAtLXJlZ2lvbj0wIGFsbAorbGli
ZGF4Y3RsOiBkYXhjdGxfZGV2X2Rpc2FibGU6IGRheDMuMDogZXJyb3I6IGRldmljZSBtb2RlbCBp
cyBkYXgtY2xhc3MKK2RheDMuMDogZGlzYWJsZSBmYWlsZWQ6IE9wZXJhdGlvbiBub3Qgc3VwcG9y
dGVkCitlcnJvciByZWNvbmZpZ3VyaW5nIGRldmljZXM6IE9wZXJhdGlvbiBub3Qgc3VwcG9ydGVk
CityZWNvbmZpZ3VyZWQgMCBkZXZpY2VzCistLS0tCisKKydkYXhjdGwtcmVjb25maWd1cmUtZGV2
aWNlJyBub21pbmFsbHkgZXhwZWN0cyB0aGF0IGl0IHdpbGwgb25saW5lIG5ldyBtZW1vcnkKK2Js
b2NrcyBhcyAnbW92YWJsZScsIHNvIHRoYXQga2VybmVsIGRhdGEgZG9lc24ndCBtYWtlIGl0IGlu
dG8gdGhpcyBtZW1vcnkuCitIb3dldmVyLCB0aGVyZSBhcmUgb3RoZXIgcG90ZW50aWFsIGFnZW50
cyB0aGF0IG1heSBiZSBjb25maWd1cmVkIHRvCithdXRvbWF0aWNhbGx5IG9ubGluZSBuZXcgaG90
LXBsdWdnZWQgbWVtb3J5IGFzIGl0IGFwcGVhcnMuIE1vc3Qgbm90YWJseSwKK3RoZXNlIGFyZSB0
aGUgJy9zeXMvZGV2aWNlcy9zeXN0ZW0vbWVtb3J5L2F1dG9fb25saW5lX2Jsb2NrcycgY29uZmln
dXJhdGlvbiwKK29yIHN5c3RlbSB1ZGV2IHJ1bGVzLiBJZiBzdWNoIGFuIGFnZW50IHJhY2VzIHRv
IG9ubGluZSBtZW1vcnkgc2VjdGlvbnMsIGRheGN0bAorY2hlY2tzIGlmIHRoZSBibG9ja3Mgd2Vy
ZSBvbmxpbmVkIGFzICdtb3ZhYmxlJyBtZW1vcnkuIElmIHRoaXMgd2FzIG5vdCB0aGUKK2Nhc2Us
IGFuZCB0aGUgbWVtb3J5IGJsb2NrcyBhcmUgZm91bmQgdG8gYmUgaW4gYSBkaWZmZXJlbnQgem9u
ZSwgdGhlbiBhCit3YXJuaW5nIGlzIGRpc3BsYXllZC4gSWYgaXQgaXMgZGVzaXJlZCB0aGF0IGEg
ZGlmZmVyZW50IGFnZW50IGNvbnRyb2wgdGhlCitvbmxpbmluZyBvZiBtZW1vcnkgYmxvY2tzLCBh
bmQgdGhlIGFzc29jaWF0ZWQgbWVtb3J5IHpvbmUsIHRoZW4gaXQgaXMKK3JlY29tbWVuZGVkIHRv
IHVzZSB0aGUgLS1uby1vbmxpbmUgb3B0aW9uIGRlc2NyaWJlZCBiZWxvdy4gVGhpcyB3aWxsIGFi
cmlkZ2UKK3RoZSBkZXZpY2UgcmVjb25maWd1cmF0aW9uIG9wZXJhdGlvbiB0byBqdXN0IGhvdHBs
dWdnaW5nIHRoZSBtZW1vcnksIGFuZAorcmVmcmFpbiBmcm9tIHRoZW4gb25saW5pbmcgaXQuCisK
K0luIGNhc2UgZGF4Y3RsIGRldGVjdHMgdGhhdCB0aGVyZSBpcyBhIGtlcm5lbCBwb2xpY3kgdG8g
YXV0by1vbmxpbmUgYmxvY2tzCisodmlhIC9zeXMvZGV2aWNlcy9zeXN0ZW0vbWVtb3J5L2F1dG9f
b25saW5lX2Jsb2NrcyksIHRoZW4gcmVjb25maWd1cmluZyB0bworc3lzdGVtLXJhbSB3aWxsIHJl
c3VsdCBpbiBhIGZhaWx1cmUuIFRoaXMgY2FuIGJlIG92ZXJyaWRkZW4gd2l0aCAnLS1mb3JjZScu
CisKKworVEhFT1JZIE9GIE9QRVJBVElPTgorLS0tLS0tLS0tLS0tLS0tLS0tLQorVGhlIGtlcm5l
bCBkZXZpY2UtZGF4IHN1YnN5c3RlbSBzdXJmYWNlcyBjaGFyYWN0ZXIgZGV2aWNlcwordGhhdCBw
cm92aWRlIERBWC1hY2Nlc3MgKGRpcmVjdCBtYXBwaW5ncyBzYW5zIHBhZ2UtY2FjaGUgYnVmZmVy
aW5nKSB0byBhCitnaXZlbiBtZW1vcnkgcmVnaW9uLiBUaGUgZGV2aWNlcyBhcmUgbmFtZWQgL2Rl
di9kYXhYLlkgd2hlcmUgWCBpcyBhCityZWdpb24taWQgYW5kIFkgaXMgYW4gaW5zdGFuY2UtaWQg
d2l0aGluIHRoYXQgcmVnaW9uLiBUaGVyZSBhcmUgMgorbWVjaGFuaXNtcyB0aGF0IHRyaWdnZXIg
ZGV2aWNlLWRheCBpbnN0YW5jZXMgdG8gYXBwZWFyOgorCisxLiBQZXJzaXN0ZW50IE1lbW9yeSAo
UE1FTSkgbmFtZXNwYWNlIGNvbmZpZ3VyZWQgaW4gImRldmRheCIgbW9kZS4gU2VlCisibmRjdGwg
Y3JlYXRlLW5hbXNwYWNlIC0taGVscCIgYW5kCitodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2RheC9L
Y29uZmlnW0NPTkZJR19ERVZfREFYX1BNRU1dLgorSW4gdGhpcyBjYXNlIHRoZSBkZXZpY2UtZGF4
IGluc3RhbmNlIGlzIHN0YXRpY2FsbHkgc2l6ZWQgdG8gaXRzIGhvc3QKK21lbW9yeSByZWdpb24g
d2hpY2ggaXMgYm91bmRlZCB0byB0aGUgcGh5c2ljYWwgYWRkcmVzcyByYW5nZSBvZiB0aGUgaG9z
dAorbmFtZXNwYWNlLgorCisyLiBTb2Z0IFJlc2VydmVkIG1lbW9yeSBlbnVtZXJhdGVkIGJ5IHBs
YXRmb3JtIGZpcm13YXJlLiBPbiBFRkkgc3lzdGVtcwordGhpcyBpcyBjb21tdW5pY2F0ZWQgdmlh
IHRoZSBzbyBjYWxsZWQgRUZJX01FTU9SWV9TUCAiU3BlY2lhbCBQdXJwb3NlIgorYXR0cmlidXRl
LiBTZWUKK2h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Rv
cnZhbGRzL2xpbnV4LmdpdC90cmVlL2RyaXZlcnMvZGF4L0tjb25maWdbQ09ORklHX0RFVl9EQVhf
SE1FTV0uCitJbiB0aGlzIGNhc2UgdGhlIGRldmljZS1kYXggaW5zdGFuY2UocykgYXNzb2NpYXRl
ZCB3aXRoIHRoZSBnaXZlbiBtZW1vcnkKK3JlZ2lvbiBjYW4gYmUgcmVzaXplZCBhbmQgZGl2aWRl
ZCBpbnRvIG11bHRpcGxlIGRldmljZXMuCisKK0luIHRoZSBTb2Z0IFJlc2VydmF0aW9uIGNhc2Ug
dGhlIGV4cGVjdGF0aW9uIGZvciBFRkkgKyBBQ1BJIGJhc2VkCitwbGF0Zm9ybXMgaXMgdGhhdCBp
biBhZGRpdGlvbiB0byB0aGUgRUZJX01FTU9SWV9TUCBhdHRyaWJ1dGUgdGhlCitmaXJtd2FyZSBh
bHNvIGNyZWF0ZXMgZGlzdGluY3QgQUNQSSBwcm94aW1pdHkgZG9tYWlucyBmb3IgYW55IGFkZHJl
c3MKK3JhbmdlIHRoYXQgaGFzIGRpZmZlcmVudCBwZXJmb3JtYW5jZSBjaGFyYWN0ZXJpc3RpY3Mg
dGhhbiBkZWZhdWx0CisiU3lzdGVtIFJBTSIuIFNvLCB0aGUgU1JBVCB3aWxsIGRlZmluZSB0aGUg
cHJveGltaXR5IGRvbWFpbiwgdGhlIFNMSVQKK2NvbW11bmljYXRlcyByZWxhdGl2ZSBkaXN0YW5j
ZSB0byBvdGhlciBwcm94aW1pdHkgZG9tYWlucywgYW5kIHRoZSBITUFUCitpcyBwb3B1bGF0ZWQg
d2l0aCBub21pbmFsIHJlYWQvd3JpdGUgbGF0ZW5jeSBhbmQgcmVhZC93cml0ZSBiYW5kd2lkdGgK
K2RhdGEuIFRoYXQgSE1BVCBkYXRhIGlzIGVtaXR0ZWQgdG8gdGhlIGtlcm5lbCBsb2cgb24gYm9v
dHVwLCBhbmQgYWxzbworZXhwb3J0ZWQgdG8gc3lzZnMuIFNlZQoraHR0cHM6Ly93d3cua2VybmVs
Lm9yZy9kb2MvaHRtbC9sYXRlc3QvYWRtaW4tZ3VpZGUvbW0vbnVtYXBlcmYuaHRtbFtOVU1BUEVS
Rl0sCitmb3IgdGhlIHJ1bnRpbWUgcmVwcmVzZW50YXRpb24gb2YgQ1BVIHRvIE1lbW9yeSBub2Rl
IHBlcmZvcm1hbmNlCitkZXRhaWxzLgorCitPdXRzaWRlIG9mIHRoZSBOVU1BIHBlcmZvcm1hbmNl
IGRldGFpbHMgbGlua2VkIGFib3ZlIHRoZSBvdGhlciBtZXRob2QgdG8KK2RldGVjdCB0aGUgcHJl
c2VuY2Ugb2YgIlNvZnQgUmVzZXJ2ZWQiIG1lbW9yeSBpcyB0byBkdW1wIC9wcm9jL2lvbWVtIGFu
ZAorbG9vayBmb3IgIlNvZnQgUmVzZXJ2ZWQiIHJhbmdlcy4gSWYgdGhlIGtlcm5lbCB3YXMgbm90
IGJ1aWx0IHdpdGgKK0NPTkZJR19FRklfU09GVFJFU0VSVkUsIHByZWRhdGVzIHRoZSBpbnRyb2R1
Y3Rpb24gb2YKK0NPTkZJR19FRklfU09GVFJFU0VSVkUgKHY1LjUpLCBvciB3YXMgYm9vdGVkIHdp
dGggdGhlIGVmaT1ub3NvZnRyZXNlcnZlCitjb21tYW5kIGxpbmUgdGhlbiBkZXZpY2UtZGF4IHdp
bGwgbm90IGF0dGFjaCBhbmQgdGhlIGV4cGVjdGF0aW9uIGlzIHRoYXQKK3RoZSBtZW1vcnkgc2hv
d3MgdXAgYXMgYSBtZW1vcnktb25seSBOVU1BIG5vZGUuIE90aGVyd2lzZSB0aGUgbWVtb3J5Citz
aG93cyB1cCBhcyBhIGRldmljZS1kYXggaW5zdGFuY2UgYW5kIERBWENUTCgxKSBjYW4gYmUgdXNl
ZCB0bworb3B0aW9uYWxseSBwYXJ0aXRpb24gaXQgYW5kIGFzc2lnbiB0aGUgbWVtb3J5IGJhY2sg
dG8gdGhlIGtlcm5lbCBhcworIlN5c3RlbSBSQU0iLCBvciB0aGUgZGV2aWNlIGNhbiBiZSBtYXBw
ZWQgZGlyZWN0bHkgYXMgdGhlIGJhY2sgZW5kIG9mIGEKK3VzZXJzcGFjZSBtZW1vcnkgYWxsb2Nh
dG9yIGxpa2UgaHR0cHM6Ly9wbWVtLmlvL3ZtZW0vbGlidm1lbS9bTElCVk1FTV0uCisKIEVYQU1Q
TEVTCiAtLS0tLS0tLQogCkBAIC04Myw0NSArMTcxLDYgQEAgcmVjb25maWd1cmVkIDEgZGV2aWNl
CiByZWNvbmZpZ3VyZWQgMSBkZXZpY2UKIC0tLS0KIAotREVTQ1JJUFRJT04KLS0tLS0tLS0tLS0t
Ci0KLVJlY29uZmlndXJlIHRoZSBvcGVyYXRpb25hbCBtb2RlIG9mIGEgZGF4IGRldmljZS4gVGhp
cyBjYW4gYmUgdXNlZCB0byBjb252ZXJ0Ci1hIHJlZ3VsYXIgJ2RldmRheCcgbW9kZSBkZXZpY2Ug
dG8gdGhlICdzeXN0ZW0tcmFtJyBtb2RlIHdoaWNoIGFycmFuZ2VzIGZvciB0aGUKLWRheCByYW5n
ZSB0byBiZSBob3QtcGx1Z2dlZCBpbnRvIHRoZSBzeXN0ZW0gYXMgcmVndWxhciBtZW1vcnkuCi0K
LU5PVEU6IFRoaXMgaXMgYSBkZXN0cnVjdGl2ZSBvcGVyYXRpb24uIEFueSBkYXRhIG9uIHRoZSBk
YXggZGV2aWNlICp3aWxsKiBiZQotbG9zdC4KLQotTk9URTogRGV2aWNlIHJlY29uZmlndXJhdGlv
biBkZXBlbmRzIG9uIHRoZSBkYXgtYnVzIGRldmljZSBtb2RlbC4gU2VlCi1saW5rZGF4Y3RsOmRh
eGN0bC1taWdyYXRlLWRldmljZS1tb2RlbFsxXSBmb3IgbW9yZSBpbmZvcm1hdGlvbi4gSWYgZGF4
LWNsYXNzIGlzCi1pbiB1c2UgKHZpYSB0aGUgZGF4X3BtZW1fY29tcGF0IGRyaXZlciksIHRoZSBy
ZWNvbmZpZ3VyYXRpb24gd2lsbCBmYWlsIHdpdGggYW4KLWVycm9yIHN1Y2ggYXMgdGhlIGZvbGxv
d2luZzoKLS0tLS0KLSMgZGF4Y3RsIHJlY29uZmlndXJlLWRldmljZSAtLW1vZGU9c3lzdGVtLXJh
bSAtLXJlZ2lvbj0wIGFsbAotbGliZGF4Y3RsOiBkYXhjdGxfZGV2X2Rpc2FibGU6IGRheDMuMDog
ZXJyb3I6IGRldmljZSBtb2RlbCBpcyBkYXgtY2xhc3MKLWRheDMuMDogZGlzYWJsZSBmYWlsZWQ6
IE9wZXJhdGlvbiBub3Qgc3VwcG9ydGVkCi1lcnJvciByZWNvbmZpZ3VyaW5nIGRldmljZXM6IE9w
ZXJhdGlvbiBub3Qgc3VwcG9ydGVkCi1yZWNvbmZpZ3VyZWQgMCBkZXZpY2VzCi0tLS0tCi0KLSdk
YXhjdGwtcmVjb25maWd1cmUtZGV2aWNlJyBub21pbmFsbHkgZXhwZWN0cyB0aGF0IGl0IHdpbGwg
b25saW5lIG5ldyBtZW1vcnkKLWJsb2NrcyBhcyAnbW92YWJsZScsIHNvIHRoYXQga2VybmVsIGRh
dGEgZG9lc24ndCBtYWtlIGl0IGludG8gdGhpcyBtZW1vcnkuCi1Ib3dldmVyLCB0aGVyZSBhcmUg
b3RoZXIgcG90ZW50aWFsIGFnZW50cyB0aGF0IG1heSBiZSBjb25maWd1cmVkIHRvCi1hdXRvbWF0
aWNhbGx5IG9ubGluZSBuZXcgaG90LXBsdWdnZWQgbWVtb3J5IGFzIGl0IGFwcGVhcnMuIE1vc3Qg
bm90YWJseSwKLXRoZXNlIGFyZSB0aGUgJy9zeXMvZGV2aWNlcy9zeXN0ZW0vbWVtb3J5L2F1dG9f
b25saW5lX2Jsb2NrcycgY29uZmlndXJhdGlvbiwKLW9yIHN5c3RlbSB1ZGV2IHJ1bGVzLiBJZiBz
dWNoIGFuIGFnZW50IHJhY2VzIHRvIG9ubGluZSBtZW1vcnkgc2VjdGlvbnMsIGRheGN0bAotY2hl
Y2tzIGlmIHRoZSBibG9ja3Mgd2VyZSBvbmxpbmVkIGFzICdtb3ZhYmxlJyBtZW1vcnkuIElmIHRo
aXMgd2FzIG5vdCB0aGUKLWNhc2UsIGFuZCB0aGUgbWVtb3J5IGJsb2NrcyBhcmUgZm91bmQgdG8g
YmUgaW4gYSBkaWZmZXJlbnQgem9uZSwgdGhlbiBhCi13YXJuaW5nIGlzIGRpc3BsYXllZC4gSWYg
aXQgaXMgZGVzaXJlZCB0aGF0IGEgZGlmZmVyZW50IGFnZW50IGNvbnRyb2wgdGhlCi1vbmxpbmlu
ZyBvZiBtZW1vcnkgYmxvY2tzLCBhbmQgdGhlIGFzc29jaWF0ZWQgbWVtb3J5IHpvbmUsIHRoZW4g
aXQgaXMKLXJlY29tbWVuZGVkIHRvIHVzZSB0aGUgLS1uby1vbmxpbmUgb3B0aW9uIGRlc2NyaWJl
ZCBiZWxvdy4gVGhpcyB3aWxsIGFicmlkZ2UKLXRoZSBkZXZpY2UgcmVjb25maWd1cmF0aW9uIG9w
ZXJhdGlvbiB0byBqdXN0IGhvdHBsdWdnaW5nIHRoZSBtZW1vcnksIGFuZAotcmVmcmFpbiBmcm9t
IHRoZW4gb25saW5pbmcgaXQuCi0KLUluIGNhc2UgZGF4Y3RsIGRldGVjdHMgdGhhdCB0aGVyZSBp
cyBhIGtlcm5lbCBwb2xpY3kgdG8gYXV0by1vbmxpbmUgYmxvY2tzCi0odmlhIC9zeXMvZGV2aWNl
cy9zeXN0ZW0vbWVtb3J5L2F1dG9fb25saW5lX2Jsb2NrcyksIHRoZW4gcmVjb25maWd1cmluZyB0
bwotc3lzdGVtLXJhbSB3aWxsIHJlc3VsdCBpbiBhIGZhaWx1cmUuIFRoaXMgY2FuIGJlIG92ZXJy
aWRkZW4gd2l0aCAnLS1mb3JjZScuCiAKIE9QVElPTlMKIC0tLS0tLS0KLS0gCjIuMzEuMQoK
--0000000000006155df05cbe53009--
