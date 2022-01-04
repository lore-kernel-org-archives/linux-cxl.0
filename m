Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4889C433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  4 Jan 2022 23:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiADXiH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 4 Jan 2022 18:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiADXiG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 4 Jan 2022 18:38:06 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8BAC061761
        for <linux-cxl@vger.kernel.org>; Tue,  4 Jan 2022 15:38:06 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso1455223pje.0
        for <linux-cxl@vger.kernel.org>; Tue, 04 Jan 2022 15:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+XwbyOAEYwKfSCbcneS+ZFrxFYsfYI1RsdWcciI7aA=;
        b=yATaJXLTbTXokuqjszBNSMBM+P7RZL3vH7npM3SW0ypWQ47HQoU3vowdmNTs8byTxh
         hVfGM+3oqACUIiYBoRwTURmDBGQqUWHN+6q8Eh0v8jz/cxBe+hUTC3H8JKVo9KSlNhvi
         ot0sdZfUBJnNrK5QVK1Cs9rxLCHAC8t4HBqt8lLxOb6qn2apvHYb3lsv3sEiaG8k1G+c
         qGMQAy/+UU3zCyLBSA7lYF+CC5h5Pfdo7GUlNvxAkoXwfixoQIlSaN0RDZZqFu1KLoQk
         ED/dMtG2RS0QOD+4MGI8/0fcXltjetrd+9aTVoYHc9sfh1s0DTwVowq/VLThwLczJJ2q
         whrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+XwbyOAEYwKfSCbcneS+ZFrxFYsfYI1RsdWcciI7aA=;
        b=DDCVeRjet07AJ1Apurvm0hvKHNQCXVYEn8kvao3ihnjgzPyzeCO6Z5icQ1tBBG7rTE
         SikibAyCqf4ci9AHMqPGsi82cnZDBiVd/SpBJNb2O/BeBbxlUAAtTHUCLSU9s2JaXLw0
         36zRaJW5Xj9+OEXUo0paUjvFm9h58UMIUQdvuePBFkIU5CIDMr4TxV4lI53FsaAhvnhD
         xoGwy5gROpvs1u8KuiD8vN7fhEyKNalROuTGOBAvuCPZlSgP2CG5furfsg8XzE6Jgthz
         gKZlc028Lu4h50nalzwdBMgyfSTFb9ZDNLa7c6/EL5ie/+ukeuxJbQr9PT4eICyRk3L/
         dICQ==
X-Gm-Message-State: AOAM530+SswlngPOtgjGRDPOw0iVWY2vf9/qkpmkqNIflW9r7syH0Arj
        fZBHxtGfqjR3bXZ6BBTQd1c6yoPBxAiPsJrtQszEvg==
X-Google-Smtp-Source: ABdhPJzAKfEMDMq7Zt/iMe6ctmXn6p0S7ob5A0UmYkTRA3k3pLSb8qFkyMh0bDg80CWZOGmMtIXmGQHSM7fUQf5OHqs=
X-Received: by 2002:a17:90a:7101:: with SMTP id h1mr848480pjk.93.1641339485712;
 Tue, 04 Jan 2022 15:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20220104232114.789948-1-alison.schofield@intel.com>
In-Reply-To: <20220104232114.789948-1-alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 4 Jan 2022 15:37:55 -0800
Message-ID: <CAPcyv4jWQSA9=TRPGcKG2qfu13JqNjPvnX_pbzMUqFa2fLZTfw@mail.gmail.com>
Subject: Re: [PATCH] cxl/mbox: Use __le32 in get,set_lsa mailbox structures
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 4, 2022 at 3:16 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> CXL specification defines these as little endian.
>
> Fixes: 60b8f17215de ("cxl/pmem: Translate NVDIMM label commands to CXL label commands")
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/cxlmem.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8d96d009ad90..eae2a687ea5d 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -221,13 +221,13 @@ struct cxl_mbox_identify {
>  } __packed;
>
>  struct cxl_mbox_get_lsa {
> -       u32 offset;
> -       u32 length;
> +       __le32 offset;
> +       __le32 length;
>  } __packed;
>
>  struct cxl_mbox_set_lsa {
> -       u32 offset;
> -       u32 reserved;
> +       __le32 offset;
> +       __le32 reserved;
>         u8 data[];
>  } __packed;

You'll also need to fixup up the users like this:

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index ceb2115981e5..90f6346c0fe1 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -108,8 +108,8 @@ static int cxl_pmem_get_config_data(struct cxl_mem *cxlm,
                return -EINVAL;

        get_lsa = (struct cxl_mbox_get_lsa) {
-               .offset = cmd->in_offset,
-               .length = cmd->in_length,
+               .offset = cpu_to_le32(cmd->in_offset),
+               .length = cpu_to_le32(cmd->in_length),
        };

        rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_GET_LSA, &get_lsa,

...etc
