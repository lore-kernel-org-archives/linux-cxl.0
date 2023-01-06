Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE83C54EBD
	for <linux-cxl@archiver.kernel.org>; Fri,  6 Jan 2023 19:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbjAFTvl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 6 Jan 2023 14:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbjAFTvk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 6 Jan 2023 14:51:40 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F941B9F0
        for <linux-cxl@vger.kernel.org>; Fri,  6 Jan 2023 11:51:16 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id i127so1919369oif.8
        for <linux-cxl@vger.kernel.org>; Fri, 06 Jan 2023 11:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TV1Qnh/cLN1HsOXBbFbIAgKPGqjhEQC/NEOpDMLQkxg=;
        b=8Qqc66TJL6uFYUS6gg4SXiwFeplLjoX6YbLF/eTB30ZfKcVnm8r5WboU6f6I+CQvLV
         2pf5E+HkWoJ3/iU6zlyZeXWDLw2y3xtxu+xbUGVQI7ocHCEaJbVjn7CutdqVdUuzCGvd
         7FrJoC5cMifKUuX+KOkOAqCstaVwZnDnzDBZZc/NHEALGJwoxR2MAD3JE7xEHrogPpa/
         sMNpTb5zp59m7/3fBTYe0riIcf5zido6ynABKuCrPpqNDkmsVAnFodYvLriVPxqd+JE+
         QOf24ZAEvxNMtdsnprwIErfUokjlbR6deWMdNMS6pDpIO5zMtQRH2BR72lQopgnCMUuu
         rQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TV1Qnh/cLN1HsOXBbFbIAgKPGqjhEQC/NEOpDMLQkxg=;
        b=x08bM+VEPqGTSfrAg7GgcEKQtY31QVidVGVInmWKzNlb+7DFfSPTzuKhGbQD5qThjU
         5lX4/n6maBMb7QwxoJkz8EVixP936fZkKk3cN8igjDA2m7PWm6pmPtrVv4XH0a3mnypn
         jXDR0ZiwDyCx5UJGPF50/3m/KiHBD+E4hpXTlb5aQ3aDno68yjCiKoJ03ToPRjCuqeqW
         R995wv5qPYkQ0qZNlKFfejtuK34V6T3fnfIUM6hGdM7/flDHHZa0QQdnlES/SgXuhAp0
         J8vtX+GVVjkOogbUE7ela9l9Ye9rOMcay7RWr6fqU1WCdNNOdWZFj7fgngK8chn9DWha
         Jcmg==
X-Gm-Message-State: AFqh2kqJg+Z+BgKECKxHiFsIRRZ7l3lgwoL/TnzIxIshxqyd41bohvQl
        M503i35/xDy1sen6n8BLLu/tByIUJK26JXZX
X-Google-Smtp-Source: AMrXdXvZ6VH7Avy/OSC9cI5tYqqI0A6fBocCYTtO6ezla02ARadmTmI04QX9L8KMi49P7URWhsQlKw==
X-Received: by 2002:aca:a90f:0:b0:35b:f66a:cc88 with SMTP id s15-20020acaa90f000000b0035bf66acc88mr25011535oie.44.1673034675714;
        Fri, 06 Jan 2023 11:51:15 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id o15-20020a9d764f000000b0066b9a6bf3bcsm972113otl.12.2023.01.06.11.51.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jan 2023 11:51:15 -0800 (PST)
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: [LSF/MM/BPF BoF] Session for CXL memory
Message-Id: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
Date:   Fri, 6 Jan 2023 11:51:04 -0800
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "Viacheslav A. Dubeyko" <viacheslav.dubeyko@bytedance.com>
To:     linux-cxl@vger.kernel.org, linux-mm@kvack.org
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

I believe CXL memory is hot topic now. I believe we have multiple topics
for discussion. I personally would like to discuss CXL Fabric Manager
and vision of FM architecture implementation. I am going to share the topic
in separate email. I would like to suggest a special session for CXL memory
related topics.

How everybody feels about it?

Thanks,
Slava.
 
