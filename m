Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A75C64EC4
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Mar 2023 21:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCFV6q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Mar 2023 16:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCFV6m (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Mar 2023 16:58:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7906046B8
        for <linux-cxl@vger.kernel.org>; Mon,  6 Mar 2023 13:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678139874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eLojvR1hlOckBZP07RQrQxEj6o/zI8InLDqt1gjySZ8=;
        b=hS7My3NozROcX4SDhaAz8pydeBb/SEpoQv1TR42Nkd0yqgXg8Rk8Xnf5siXZ0xyyTcTEWE
        98nECJy1Fu5W/gojShBISRGF87z/g4gH0iHgtSDjRmXn30jZ25K980HNY14QZhJjRD3k14
        cf3kj9o8nQIZxZ/Invdk+qFE5nXr3Ak=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-cDb4AWlJNrGFVeYeky_hag-1; Mon, 06 Mar 2023 16:57:53 -0500
X-MC-Unique: cDb4AWlJNrGFVeYeky_hag-1
Received: by mail-wm1-f69.google.com with SMTP id c7-20020a7bc847000000b003e00be23a70so7332481wml.2
        for <linux-cxl@vger.kernel.org>; Mon, 06 Mar 2023 13:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678139872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLojvR1hlOckBZP07RQrQxEj6o/zI8InLDqt1gjySZ8=;
        b=J611fghK1UQZ0KttDD1A4uU4M1b3rqwg4Qb+N+1gy4pmahquXl+/mbL4+balWFiuRL
         FH1oVVghSKLz8cJiO0kzbbk+luUsX8FAAheaeRQ7qtZfvnVtp4TW4ICj43yakdOqgRcF
         y8Y1w6fW9MGWpolJhm0hIDNBIm5wNyJTD9vdaP7FbjcMX5G+fPcqjcR/+a+xyeqxKHe2
         Dy9Nk2V+5yiD0rqQv4if6jcRHeSQEd7uRFL9YwfCo39pe7j1s2MYmD+qMDKeFI/qdJM2
         7431eaQ/QZWvO/z3idN2nfZwM7yXvSVVCbx8DLn8xyAjeBaH/J0EXhdV+l+/ChMnq1k3
         +6XQ==
X-Gm-Message-State: AO0yUKV/eI/LRqaW1NBhPhZs6M+gr+Yk3dxuvZZNUevxsX+iEPrcuuYt
        bbUKppS1gGX/eVtWoruEKa43ehIiZoudfbmXmabo2TXi8RVGpTvQ3po1a4GEe/0bOsSZYlXiJ+Z
        bCwLA+rrkui/su8g4kxKJbRy0HT0y
X-Received: by 2002:a5d:4569:0:b0:2c7:6a6c:c71e with SMTP id a9-20020a5d4569000000b002c76a6cc71emr8396720wrc.70.1678139872331;
        Mon, 06 Mar 2023 13:57:52 -0800 (PST)
X-Google-Smtp-Source: AK7set8p3a3/3dcqjwsFFFE6TZUOMkcEK9VGUcMyANC0GcKp6I5oTKstkY9n3pxkoBRjije4CVEIgg==
X-Received: by 2002:a5d:4569:0:b0:2c7:6a6c:c71e with SMTP id a9-20020a5d4569000000b002c76a6cc71emr8396710wrc.70.1678139871985;
        Mon, 06 Mar 2023 13:57:51 -0800 (PST)
Received: from redhat.com ([2.52.23.160])
        by smtp.gmail.com with ESMTPSA id m14-20020adffe4e000000b002c54c8e70b1sm11129334wrs.9.2023.03.06.13.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 13:57:51 -0800 (PST)
Date:   Mon, 6 Mar 2023 16:57:46 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [RESEND PATCH v6 0/8] hw/cxl: RAS error emulation and injection
Message-ID: <20230306165630-mutt-send-email-mst@kernel.org>
References: <20230302133709.30373-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230302133709.30373-1-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 02, 2023 at 01:37:01PM +0000, Jonathan Cameron wrote:
> Resending to expand CC list. Looking in particular for review of the QAPI
> part of patch 8.

Given QAPI has to be maintained for a long time,
I guess it'll have to wait until next release unless
someone acks it ASAP.

-- 
MST

