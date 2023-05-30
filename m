Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF0CC77B7A
	for <linux-cxl@archiver.kernel.org>; Tue, 30 May 2023 22:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjE3WnU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 May 2023 18:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjE3WnT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 May 2023 18:43:19 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378F710A
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 15:43:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2af2ef0d0daso52790521fa.2
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685486593; x=1688078593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8RVXLYgdzUMV2q+6sOMeXIaKNwf83t9uqStvN0uPe4=;
        b=dKveP6ipxEp3Shiie7EcNlQLqfCSPHCSuSWwct2C8fNa3z2smQZ5x82L1AfFtbZQbE
         f+mbLo34TgNhELb1iYmU7oZhFFePacmZDYZTF7mw7LMD581jzm70W14PbDE1LZY0YB3z
         N5LLs90PPDPiQO8+LzNDbYKdgp/f4wr4O2Zck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685486593; x=1688078593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8RVXLYgdzUMV2q+6sOMeXIaKNwf83t9uqStvN0uPe4=;
        b=LlsXGhkQ8uZ6iu2GaGsoJTYTwjonHANpEi5Y2YwFEEsjKqNTh7nOpGv0XF5U4oB5fZ
         39ExiHoZiweOprcp47ckJMOl8mXnMZ6VYEuN3shhI4i3iz9jyGL67KpMNImmDl1PKz71
         nAYm0bcrk7z4UQQuvEQJm1oV6hnSNQLcitje3IO+3GlDTs5lHYeE+su1FuG5xDRxrI/b
         KyZ1bMYVGuAZjrnVqHrm+vsIYrdt9FWrcuGOvJtT+jZUcLvnYmVIjVTyQ88yLBpD5T8n
         VOnD2vPdLwhZQScnHB3GY1T4eW0jRExsYtxiBzObhEt5A7DpHgHwyeNOlJai0SSsG+y3
         37uw==
X-Gm-Message-State: AC+VfDwQTfQ0kx31QLl0xwkHAM7v85jQ302ZpRDAGW6lJfH5DpthIWuC
        uNgfg9SrrtKBmxCCTX7Rbargt88WCsqBtCj9LO8XM3Ri
X-Google-Smtp-Source: ACHHUZ5J4ATT3rBVhedM2SB86NkP+bfIveUYF1Xwv+WuhPUweirx5HbGDJE5KKVgjmTz+RS3ohIYYw==
X-Received: by 2002:a05:651c:10b:b0:2af:b4b:8583 with SMTP id a11-20020a05651c010b00b002af0b4b8583mr1475546ljb.15.1685486593104;
        Tue, 30 May 2023 15:43:13 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id am10-20020a170906568a00b0096ae152115bsm8030731ejc.175.2023.05.30.15.43.12
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 15:43:12 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-96f8d485ef3so786154866b.0
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 15:43:12 -0700 (PDT)
X-Received: by 2002:a17:907:3da1:b0:96f:aacb:6f15 with SMTP id
 he33-20020a1709073da100b0096faacb6f15mr2905332ejc.31.1685486592131; Tue, 30
 May 2023 15:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVZSBx-=Sm8ZM12dWY4hmpnfDdhmg6UwXsR4OLSgPXY2w@mail.gmail.com>
 <64766df07f013_e067a29410@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=whWJFw8+HP=0-ZaQYq2VVPtv1StFhUxgiJW1_FWdtgJSA@mail.gmail.com> <64767669744d4_168e29489@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64767669744d4_168e29489@dwillia2-xfh.jf.intel.com.notmuch>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 May 2023 18:42:55 -0400
X-Gmail-Original-Message-ID: <CAHk-=whHjT-KWPjQK8iSaHJa7WX_LuKgZt_iX+jDxRxDD2Zjdg@mail.gmail.com>
Message-ID: <CAHk-=whHjT-KWPjQK8iSaHJa7WX_LuKgZt_iX+jDxRxDD2Zjdg@mail.gmail.com>
Subject: Re: Revert "module: error out early on concurrent load of the same
 module file"
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, May 30, 2023 at 6:19=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> I know that the "Link:" for "mailing-list thread where patch originated"
> is mostly useless information [1], but when it comes to quickly reporting
> test results on the output of "git bisect", it comes in handy.

It was literally there in this case. We had multiple links, and you
may just have been overwhelmed by the pure cornucopia of links.

In this case is was the third one:

    Link: https://lore.kernel.org/lkml/ZG%2Fa+nrt4%2FAAUi5z@bombadil.infrad=
ead.org/
[3]

which linked to that thread.

It's the links to pure patch submissions that are useless (ie the
"this is where I sent the patch"). Those lore can find for you
automatically.

Links to actual threads with background and test commentary are
useful, and I add those myself. There were several of them.

                  Linus
