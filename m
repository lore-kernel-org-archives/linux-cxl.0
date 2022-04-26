Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A17CC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 26 Apr 2022 19:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345389AbiDZTEE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 26 Apr 2022 15:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbiDZTED (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 26 Apr 2022 15:04:03 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C11D1569D3
        for <linux-cxl@vger.kernel.org>; Tue, 26 Apr 2022 12:00:53 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i24so18793358pfa.7
        for <linux-cxl@vger.kernel.org>; Tue, 26 Apr 2022 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5c5B+FYG2hMjHYPTaGI7KmWrGDEmgijpy5n1QmZ0a3Y=;
        b=mCHkWRUe4n2T9t3YJuJbBd3+c2A5/w6jo73X+nmEOsdLprNGi3WbxM3PwX41Pd04yT
         JKwv4/wJQAI54ACIEmczTh/7Q9zFC3qzANLXEJ4JXp85FapCFw4McuhGf9gmand+aw+E
         30Rmv/Vor0Ml2OODzhFcXnqmNsIsG/UL8yODY9JqUnSn/b9PjehWG1Amsizurie2Iqkc
         uvVlLTRS9jyeKvbjKi5a9IzYwB+hDqBSkwErTura0U5v+F4I4SmtQQGRFzxWCvO1ErK9
         PwSFQEjbb0Xt3/mTg1I2RCQsCg4OtIoTJS2HDn2k2AQbU1PwFNNYwgXJn11yXQ4SqzEO
         x0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5c5B+FYG2hMjHYPTaGI7KmWrGDEmgijpy5n1QmZ0a3Y=;
        b=8Mq74bfeyH46JyXztVT6lYY3L3xZ26vTjLa/oZB4QGXLCFlcNsTJKbef7FlirF0Qc4
         XykZ2SbPlQhgg/1IOUA7sjNBGBXcOThKayajNHHKIsEK7AH2/GFNpC3dyaAj4bbvrpOK
         k+l1WhvFsZlvdB3tzFZfzgzv9SsrUZRNkKRlbf6u5GGCiQ5Y6FWuU3u02wLcZHZ2MgWq
         S2TnTcGwqZiCfFJw8htRtF/KlAITKiQM2uqtOuDAMZh6CxKc/Fw53Uz095hjdYJOiiJE
         GFfLXOzDHfBiA+Sr1JimqayQJrC6gyWksHeUbPbaE91ywZFtN63YCY7euKbEHNEjPUKM
         tYuw==
X-Gm-Message-State: AOAM532RP052sLgxmWkAgWIMTLSCCzatHM3G65J57JOQQQlbVsNGPbYM
        3xHiuihcWeue3vFkkvxCl+pnXozrfjCjAlC8fg9VMg==
X-Google-Smtp-Source: ABdhPJxCjVAAIQuEHxZG8lMducI8/fNi6BXPBvoYjisDBMJxXWaAwBejBHnH9IsS3WSmCsMx6cv/9+gw6kdlRyCaz70=
X-Received: by 2002:a05:6a00:2992:b0:505:cf4b:baef with SMTP id
 cj18-20020a056a00299200b00505cf4bbaefmr25643762pfb.61.1650999653090; Tue, 26
 Apr 2022 12:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220426180832.00005f0b@Huawei.com> <CAPcyv4i+=ArjE7uH_jKGS+B9-dLJ3An_T+NgWB2xqC-7Zh-VYA@mail.gmail.com>
 <20220426190615.000063ed@Huawei.com>
In-Reply-To: <20220426190615.000063ed@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Apr 2022 12:00:41 -0700
Message-ID: <CAPcyv4gjn7MAo-kzW40EAc9J6zQaOKh0a-42GyV1X5Efac_W_Q@mail.gmail.com>
Subject: Re: CXL type 3 which doesn't have cxl mem enabled.
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: multipart/mixed; boundary="000000000000d9743305dd934fc4"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

--000000000000d9743305dd934fc4
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 26, 2022 at 11:06 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 26 Apr 2022 10:19:55 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Tue, Apr 26, 2022 at 10:09 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > Hi All,
> > >
> > > I ran into this whilst debugging why on the current QEMU code
> > > we now get a probe failure for CXL mem due to the range 1 size being
> > > non 0.
> > >
> > > The conditions for whether we have legacy ranges programmed don't
> > > take into account if Mem_Enable = 1.  That is if the
> > > DVSEC CXL Control Mem_Enable bit is set on the type 3 device.
> > > If it's not then there is no existing user of the CXL memory
> > > setup by firmware or similar so we can switch over to HDM
> > > decoders and it doesn't matter what is in the range registers.
> > >
> > > Unfortunately the QEMU code was bringing the device up with
> > > Mem_Enabled already set.  So I fixed that.  After all default
> > > value of that bit should be 0.
> > >
> > > A few problems then showed up.
> > >
> > > 1. Nothing in the Linux code actually sets Mem_Enabled to 1.
>
> Sorry - my mistake, that should be Mem_Enable. Though that doesn't
> actually clarify things much...
>
> >
> > That's because the device is supposed to, I though, set it of its own
> > accord as a result of link training. It's an RO field in the spec, so
> > Linux can't set it:
> >
> > 8.2.1.3.3 DVSEC Flex Bus Port Status (Offset 0Eh)
> > "Mem_Enabled: When set, indicates that CXL.mem protocol operation has
> > been enabled as a result of PCIe alternate protocol negotiation for
> > Flex Bus."
>
> Agreed with that statement.
>
> Ah. Nothing like confusing register field names that are very similar....
> A Mem_Enable is in DVSEC for CXL Device 8.1.3.2 and is RWL.
> Just for giggles there is also a Mem_Enable in the Flex Bus Port Control
> but the range registers comment isn't about that one (I hope anyway!).

Not sure whether to laugh or cry at that, sorry for the mix up on my part.

> The kernel currently sets the value of info->mem_enabled using
> the Mem_Enable field of the DVSEC for CXL Device.
> https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/cxl/pci.c#L501
>
> So I think wrong name and wrong DVSEC for that particular condition.

Yeah, I don't even see a need to cache that value, so something like
the attached? Note that the intent was to only have cxl_mem worry
about MMIO mapped register details and not require the 'struct
pci_dev' which makes things easier for cxl_test in the near term.

--000000000000d9743305dd934fc4
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_l2gijar30>
X-Attachment-Id: f_l2gijar30

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2N4bG1lbS5oIGIvZHJpdmVycy9jeGwvY3hsbWVtLmgK
aW5kZXggNzIzNWQyZjk3NmU1Li5lZjY5NTBhMmE0ZmQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY3hs
L2N4bG1lbS5oCisrKyBiL2RyaXZlcnMvY3hsL2N4bG1lbS5oCkBAIC0xNTAsMTIgKzE1MCwxMCBA
QCBzdGF0aWMgaW5saW5lIGludCBjeGxfbWJveF9jbWRfcmMyZXJybm8oc3RydWN0IGN4bF9tYm94
X2NtZCAqbWJveF9jbWQpCiAKIC8qKgogICogc3RydWN0IGN4bF9lbmRwb2ludF9kdnNlY19pbmZv
IC0gQ2FjaGVkIERWU0VDIGluZm8KLSAqIEBtZW1fZW5hYmxlZDogY2FjaGVkIHZhbHVlIG9mIG1l
bV9lbmFibGVkIGluIHRoZSBEVlNFQywgUENJRV9ERVZJQ0UKICAqIEByYW5nZXM6IE51bWJlciBv
ZiBhY3RpdmUgSERNIHJhbmdlcyB0aGlzIGRldmljZSB1c2VzLgogICogQGR2c2VjX3JhbmdlOiBj
YWNoZWQgYXR0cmlidXRlcyBvZiB0aGUgcmFuZ2VzIGluIHRoZSBEVlNFQywgUENJRV9ERVZJQ0UK
ICAqLwogc3RydWN0IGN4bF9lbmRwb2ludF9kdnNlY19pbmZvIHsKLQlib29sIG1lbV9lbmFibGVk
OwogCWludCByYW5nZXM7CiAJc3RydWN0IHJhbmdlIGR2c2VjX3JhbmdlWzJdOwogfTsKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY3hsL21lbS5jIGIvZHJpdmVycy9jeGwvbWVtLmMKaW5kZXggNDAxYjBm
YmUyMWRiLi5jMmQ5ZGFkZjRhMmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY3hsL21lbS5jCisrKyBi
L2RyaXZlcnMvY3hsL21lbS5jCkBAIC0yNywxMiArMjcsOCBAQAogc3RhdGljIGludCB3YWl0X2Zv
cl9tZWRpYShzdHJ1Y3QgY3hsX21lbWRldiAqY3hsbWQpCiB7CiAJc3RydWN0IGN4bF9kZXZfc3Rh
dGUgKmN4bGRzID0gY3hsbWQtPmN4bGRzOwotCXN0cnVjdCBjeGxfZW5kcG9pbnRfZHZzZWNfaW5m
byAqaW5mbyA9ICZjeGxkcy0+aW5mbzsKIAlpbnQgcmM7CiAKLQlpZiAoIWluZm8tPm1lbV9lbmFi
bGVkKQotCQlyZXR1cm4gLUVCVVNZOwotCiAJcmMgPSBjeGxkcy0+d2FpdF9tZWRpYV9yZWFkeShj
eGxkcyk7CiAJaWYgKHJjKQogCQlyZXR1cm4gcmM7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9w
Y2kuYyBiL2RyaXZlcnMvY3hsL3BjaS5jCmluZGV4IGU3YWI5YTM0ZDcxOC4uNWM4ZjkzM2JiZWNl
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2N4bC9wY2kuYworKysgYi9kcml2ZXJzL2N4bC9wY2kuYwpA
QCAtNDYzLDYgKzQ2MywxNyBAQCBzdGF0aWMgaW50IHdhaXRfZm9yX21lZGlhX3JlYWR5KHN0cnVj
dCBjeGxfZGV2X3N0YXRlICpjeGxkcykKIAlyZXR1cm4gMDsKIH0KIAorc3RhdGljIHZvaWQgY3hs
X2Rpc2FibGVfbWVtKHZvaWQgKnBkZXYpCit7CisJc3RydWN0IGN4bF9kZXZfc3RhdGUgKmN4bGRz
ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOworCWludCBkID0gY3hsZHMtPmN4bF9kdnNlYzsKKwl1
MTYgY3RybDsKKworCXBjaV9yZWFkX2NvbmZpZ193b3JkKHBkZXYsIGQgKyBDWExfRFZTRUNfQ1RS
TF9PRkZTRVQsICZjdHJsKTsKKwljdHJsICY9IH5DWExfRFZTRUNfTUVNX0VOQUJMRTsKKwlwY2lf
d3JpdGVfY29uZmlnX3dvcmQocGRldiwgZCArIENYTF9EVlNFQ19DVFJMX09GRlNFVCwgY3RybCk7
Cit9CisKIC8qCiAgKiBSZXR1cm4gcG9zaXRpdmUgbnVtYmVyIG9mIG5vbi16ZXJvIHJhbmdlcyBv
biBzdWNjZXNzIGFuZCBhIG5lZ2F0aXZlCiAgKiBlcnJvciBjb2RlIG9uIGZhaWx1cmUuIFRoZSBj
eGxfbWVtIGRyaXZlciBkZXBlbmRzIG9uIHJhbmdlcyA9PSAwIHRvCkBAIC00ODYsMTMgKzQ5Nywy
NiBAQCBzdGF0aWMgaW50IF9fY3hsX2R2c2VjX3JhbmdlcyhzdHJ1Y3QgY3hsX2Rldl9zdGF0ZSAq
Y3hsZHMsCiAJaWYgKHJjKQogCQlyZXR1cm4gcmM7CiAKKwlpZiAoIShjYXAgJiBDWExfRFZTRUNf
TUVNX0NBUEFCTEUpKSB7CisJCWRldl9kYmcoZGV2LCAiTm90IE1FTSBDYXBhYmxlXG4iKTsKKwkJ
cmV0dXJuIC1FTlhJTzsKKwl9CisKIAlyYyA9IHBjaV9yZWFkX2NvbmZpZ193b3JkKHBkZXYsIGQg
KyBDWExfRFZTRUNfQ1RSTF9PRkZTRVQsICZjdHJsKTsKIAlpZiAocmMpCiAJCXJldHVybiByYzsK
IAotCWlmICghKGNhcCAmIENYTF9EVlNFQ19NRU1fQ0FQQUJMRSkpIHsKLQkJZGV2X2RiZyhkZXYs
ICJOb3QgTUVNIENhcGFibGVcbiIpOwotCQlyZXR1cm4gLUVOWElPOworCWlmICghKGN0cmwgJiBD
WExfRFZTRUNfTUVNX0VOQUJMRSkpIHsKKwkJY3RybCB8PSBDWExfRFZTRUNfTUVNX0VOQUJMRTsK
KwkJcmMgPSBwY2lfd3JpdGVfY29uZmlnX3dvcmQocGRldiwgZCArIENYTF9EVlNFQ19DVFJMX09G
RlNFVCwKKwkJCQkJICAgY3RybCk7CisJCWlmIChyYykKKwkJCXJldHVybiByYzsKKworCQlyYyA9
IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgmcGRldi0+ZGV2LCBjeGxfZGlzYWJsZV9tZW0sCisJ
CQkJCSAgICAgIHBkZXYpOworCQlpZiAocmMpCisJCQlyZXR1cm4gcmM7CiAJfQogCiAJLyoKQEAg
LTUxMSw4ICs1MzUsNiBAQCBzdGF0aWMgaW50IF9fY3hsX2R2c2VjX3JhbmdlcyhzdHJ1Y3QgY3hs
X2Rldl9zdGF0ZSAqY3hsZHMsCiAJCXJldHVybiByYzsKIAl9CiAKLQlpbmZvLT5tZW1fZW5hYmxl
ZCA9IEZJRUxEX0dFVChDWExfRFZTRUNfTUVNX0VOQUJMRSwgY3RybCk7Ci0KIAlmb3IgKGkgPSAw
OyBpIDwgaGRtX2NvdW50OyBpKyspIHsKIAkJdTY0IGJhc2UsIHNpemU7CiAJCXUzMiB0ZW1wOwpA
QCAtNTg1LDYgKzYwNyw3IEBAIHN0YXRpYyBpbnQgY3hsX3BjaV9wcm9iZShzdHJ1Y3QgcGNpX2Rl
diAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKQogCWN4bGRzID0gY3hsX2Rl
dl9zdGF0ZV9jcmVhdGUoJnBkZXYtPmRldik7CiAJaWYgKElTX0VSUihjeGxkcykpCiAJCXJldHVy
biBQVFJfRVJSKGN4bGRzKTsKKwlwY2lfc2V0X2RydmRhdGEocGRldiwgY3hsZHMpOwogCiAJY3hs
ZHMtPnNlcmlhbCA9IHBjaV9nZXRfZHNuKHBkZXYpOwogCWN4bGRzLT5jeGxfZHZzZWMgPSBwY2lf
ZmluZF9kdnNlY19jYXBhYmlsaXR5KApkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9jeGwvdGVz
dC9tZW0uYyBiL3Rvb2xzL3Rlc3RpbmcvY3hsL3Rlc3QvbWVtLmMKaW5kZXggYjZiNzI2ZWZmM2Uy
Li40NGQwMTIyNDczNGEgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3RpbmcvY3hsL3Rlc3QvbWVtLmMK
KysrIGIvdG9vbHMvdGVzdGluZy9jeGwvdGVzdC9tZW0uYwpAQCAtMjUwLDEwICsyNTAsNiBAQCBz
dGF0aWMgdm9pZCBsYWJlbF9hcmVhX3JlbGVhc2Uodm9pZCAqbHNhKQogCiBzdGF0aWMgdm9pZCBt
b2NrX3ZhbGlkYXRlX2R2c2VjX3JhbmdlcyhzdHJ1Y3QgY3hsX2Rldl9zdGF0ZSAqY3hsZHMpCiB7
Ci0Jc3RydWN0IGN4bF9lbmRwb2ludF9kdnNlY19pbmZvICppbmZvOwotCi0JaW5mbyA9ICZjeGxk
cy0+aW5mbzsKLQlpbmZvLT5tZW1fZW5hYmxlZCA9IHRydWU7CiB9CiAKIHN0YXRpYyBpbnQgY3hs
X21vY2tfbWVtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCg==
--000000000000d9743305dd934fc4--
