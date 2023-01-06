Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9842EC54EBD
	for <linux-cxl@archiver.kernel.org>; Fri,  6 Jan 2023 22:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbjAFWVW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 6 Jan 2023 17:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjAFWVR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 6 Jan 2023 17:21:17 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9FD7DE1B
        for <linux-cxl@vger.kernel.org>; Fri,  6 Jan 2023 14:20:54 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id c133so2249400oif.1
        for <linux-cxl@vger.kernel.org>; Fri, 06 Jan 2023 14:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wC4C81PQaQbKjpN0OwmJQBjUegGeP3pjmqO60ZPeBI=;
        b=03uEizZq8EP4LuxeClb6BodnINm7GcvWUeAjT0SeR6mYNw8phKR+hXqB7uhDkjMj2I
         8g2ISFsYWnMMxwpdwx6StvPWN7CzVww3VQbT5OUQ4zBuP0MWQe5YZqK4FQGxENHuL9Ia
         eq8FsQ+5cwhlHmeHsSA13kfMWmyj5J3VJf4O6abBwDyfIG5YSHpK2SUIqaJPvoWGGcc0
         +iGDamfTC7WN6qAPgkZXUaLE068th3T1IeVCtvX1bJmpDonPuBzkcixZhHxgBqz4M0pl
         qUCabxuGOfvHnQimF5FddTP5jTtVvlhibuNOqyjT7Ot0xdoEwugZuu0bpRc0goAvAs2I
         H4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wC4C81PQaQbKjpN0OwmJQBjUegGeP3pjmqO60ZPeBI=;
        b=5c+Obf1axv+AIbO+kPqFHZvAT2hMp8rGsxgzvL+rQe5qFZFBD3Ke5u+P0cUx/VKj6/
         OJUMJvfFbKbpRKkipzDCnUyADEsUsmHOt/1YmTpsJyYwUo4ASOYnYTJiZKmMNRnF21JO
         QXWo8dZEvDqMRaZ9vbZG1kJePhlfDZB6MXkw+n5mcU7rwh/Lk5zQy4lmLMwptdZ0u9JR
         lYaMlGR2QEXj/XPmG9RW0D0AJaYiSGFhYS5TnyCbvTuFn9oZ7w2eHwxVgyXCH59B6h5i
         1wJI4I4+4em0NvDqesbT7pkW0U6wJ79o+V+7d17yeZsuaOcuP3QPxIcgXt7tDvE6/nA7
         PINA==
X-Gm-Message-State: AFqh2kpyKP5BSsj0j9wWQRayFXpDcc6wldwyHVQZD0A6WJb9pyUQOOLo
        60vkUcJIQGG/lIHMCblUx6/6yw==
X-Google-Smtp-Source: AMrXdXvj6h+P6ZNKGSMy+N/UiCzilvhw7qohqhlOxZv9rpNzwYu8NHEb3woJe7PhWh3GlFLv+tYSjg==
X-Received: by 2002:a05:6808:298c:b0:361:1a1:316 with SMTP id ex12-20020a056808298c00b0036101a10316mr23054395oib.33.1673043653934;
        Fri, 06 Jan 2023 14:20:53 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id b19-20020a9d6b93000000b0066ca61230casm1116074otq.8.2023.01.06.14.20.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jan 2023 14:20:53 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [LSF/MM/BPF BoF] Session for CXL memory
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
Date:   Fri, 6 Jan 2023 14:20:42 -0800
Cc:     linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com>
References: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
To:     lsf-pc@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CC: LSF/MM/BPF mailing list. Sorry, missed the list.

> On Jan 6, 2023, at 11:51 AM, Viacheslav A.Dubeyko =
<viacheslav.dubeyko@bytedance.com> wrote:
>=20
> Hello,
>=20
> I believe CXL memory is hot topic now. I believe we have multiple =
topics
> for discussion. I personally would like to discuss CXL Fabric Manager
> and vision of FM architecture implementation. I am going to share the =
topic
> in separate email. I would like to suggest a special session for CXL =
memory
> related topics.
>=20
> How everybody feels about it?
>=20
> Thanks,
> Slava.
>=20

