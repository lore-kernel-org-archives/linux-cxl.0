Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333FDC38142
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 18:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjAWSb4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjAWSbo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 13:31:44 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1088B32529
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 10:30:57 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d16so10400261qtw.8
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 10:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNmPm9t9t/ZTMR72Q2Xt1kEf8fqqLweg/v/k+OgxP4M=;
        b=yI7Dkp7ur8FBOF8Ov6kNhJ1c3HchfupkLhqTDZM9wDZcYtaKvrDfvIKqRR4/mFWY+x
         3s811bq4MCEqw26+0wOmn92edBkQ1AofUj2ySSmOiOWi3/tKtG2xREfuJ2kXj3fzQy7L
         5xEkjzQv13c+njD/rfZj/EreIlL7W4JlnKYf4jWavhh8oLsWv6CUVbgUYevr3ylqvn5W
         MSkDvwTIPOiW1Nlb5mYVQ0MGf08WBy0auYHDJuiy57UD5O4s0ZqVaEZvboDPNfDs+kKc
         ssJpLbpH6pIADxceEcEOgpLbejZ15PDGX5vlCzlFPHtbiEkp5xcyA27xIUQDAMNzcHDZ
         NFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNmPm9t9t/ZTMR72Q2Xt1kEf8fqqLweg/v/k+OgxP4M=;
        b=tzCy4EYqi9qZ8vFu0WNXPyp4lXK7kvqUMuaU/RH++pTgMhE7kVsK6J9Vkz6bWy4Qwf
         8wCSTT31uMZzECD4j8azElcrLUPxZ7H/0tJ6OendSNvqeuEPh0q15CYGweWi62GcoMwR
         zDw/Rh+lz8jTqdY0i5tebYvxcjLtVlpCTMpZipz6IDw7+8WfvEw5wHTfkuBtbF3mfFLa
         Dz57Xs/7KZmpqCEJuMbLvM7gzB6mLtnD6GTF7XiDT+ml8WQBNrqcyShYCuY7YrcZnYo7
         ePbdPwWxq/+44egNSaQEpL83thAoAGJmYGo/79fl57P8s32N9Oov9/XgGjH7M2WsNe95
         lw4w==
X-Gm-Message-State: AFqh2krgyc0u0wuDmRtXxsAnDEBIr/juBRfUkpFiKy8vargqb8DzfiFJ
        88FTtNZzp5xqesGFJCcZzC/Qyg==
X-Google-Smtp-Source: AMrXdXsgRIiK31IFFhhyN5PO2XPz4CRNnmyrnGN/wmgIVQptgDtcHRxfpMQRfZOwKe0iWZ6Fga9cNg==
X-Received: by 2002:a05:622a:1748:b0:3b6:8881:6b07 with SMTP id l8-20020a05622a174800b003b688816b07mr36870137qtk.48.1674498647306;
        Mon, 23 Jan 2023 10:30:47 -0800 (PST)
Received: from smtpclient.apple (ec2-52-52-7-82.us-west-1.compute.amazonaws.com. [52.52.7.82])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a0f0e00b006fbb4b98a25sm32435911qkl.109.2023.01.23.10.30.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jan 2023 10:30:47 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF BoF] Session for CXL memory
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20230123174553.GA341216@bgt-140510-bm01>
Date:   Mon, 23 Jan 2023 10:30:34 -0800
Cc:     David Rientjes <rientjes@google.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Duen-wen Hsiao <duenwen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Fan Ni <fan.ni@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1AF948D-C703-44E9-A668-602F9FE621C3@bytedance.com>
References: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
 <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com>
 <CGME20230123055124uscas1p24ec9bf64b225fa5d943dd94ff70311ba@uscas1p2.samsung.com>
 <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
 <20230123174553.GA341216@bgt-140510-bm01>
To:     Adam Manzanares <a.manzanares@samsung.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On Jan 23, 2023, at 9:46 AM, Adam Manzanares =
<a.manzanares@samsung.com> wrote:
>=20
> On Sun, Jan 22, 2023 at 09:51:19PM -0800, David Rientjes wrote:
>> On Fri, 6 Jan 2023, Viacheslav A.Dubeyko wrote:
>>=20
>>> CC: LSF/MM/BPF mailing list. Sorry, missed the list.
>>>=20
>>>> On Jan 6, 2023, at 11:51 AM, Viacheslav A.Dubeyko =
<viacheslav.dubeyko@bytedance.com> wrote:
>>>>=20
>>>> Hello,
>>>>=20
>>>> I believe CXL memory is hot topic now. I believe we have multiple =
topics
>>>> for discussion. I personally would like to discuss CXL Fabric =
Manager
>>>> and vision of FM architecture implementation. I am going to share =
the topic
>>>> in separate email. I would like to suggest a special session for =
CXL memory
>>>> related topics.
>>>>=20
>>>> How everybody feels about it?
>>>>=20
>>=20
>> I think this makes a lot of sense, thanks for suggesting it.
>>=20
>> Should this be a BoF or just a normal topic proposal?  I assume that =
there=20
>> could be several different topics of interest all related to CXL.mem.
>>=20
>=20
> +1 for a normal topic proposal.

By the way, Samsung SMDK (memory development kit) suggested memory model
in user-space and kernel memory subsystem modification. I assume that we =
need
to discuss the memory model and kernel-space modification. So, it could =
be one of
the CXL related topic. Could we expect that Samsung guys deliver a talk?

Thanks,
Slava.

