Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F54C433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Nov 2021 02:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B486D610FC
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Nov 2021 02:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhKDCbZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Nov 2021 22:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhKDCbZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Nov 2021 22:31:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D889CC061714
        for <linux-cxl@vger.kernel.org>; Wed,  3 Nov 2021 19:28:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n8so4807965plf.4
        for <linux-cxl@vger.kernel.org>; Wed, 03 Nov 2021 19:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i0D7c93onpQrMMdroXb3+B3hHAKAmBczwgwNZylkEMo=;
        b=XXfzBMBaSANCnOwRharl2+9+kcN9yxpdlYfVB/GALrv22Nggm2l4QJ9ZKQjZw7gOaE
         uXdq+Hn6cMiL1OFcecwPFVxA6lJORnAQbxXO1Snm3j/nusE5Gimd6VclPqkb/aPjk1gJ
         suat26OXTHi/Vs0PrCCCjzIG9bO54lay39C90s4gEjGB4zFiUjsBVeIlsf9wKI1mX4dL
         0fDU75Lw1YzwIhaxvV86I9zX8HscEgjNep02GLa4Wvy6a5eisCafGahh+NhWQjJg8WT3
         EqRTXSoaTTLaRKW23QrYja0BO3oflQ3vzdP+gJeuS/c0R0+Um1cKDSBkIKLryLL/th8y
         hy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0D7c93onpQrMMdroXb3+B3hHAKAmBczwgwNZylkEMo=;
        b=vzjW/m1oDHRY4+bBwPoBLYpWpJsd8zAwmr/hv1Cy1peojj09qlWDLH9I3XmRjAO00K
         +rnwlSN6sjdxLPNzWQEIyOtJjNUhgwf3e3Ivk0ZFjKUPN/J/UkMPgroR4M2I7KMklYB1
         8NKugWM3uNT7mSNIMRHWFGGUGJgEZtUGZKy9maSmDAxwFsbaayPE+nenhNIDMYWIb8Zq
         wywjCbQMSYS8p+cnLx2q4ZIvhURnaMwruYa+eCM95/PUonzE5Hymp/RQLO4qh8JjmKrv
         RuwTef54RD2Xrs/WD3WnmZA5vv9C+Ytq5xqdLpeF17lfNGTsgZn1YD8VxrAOr/anzqK0
         LpPQ==
X-Gm-Message-State: AOAM531oFXH3yDVY11fWxJlvv623nS96SkS6kcgqJZRUaJCaTr6AfWag
        G4PwFKXPkhK1Ceq2kp9XVENWCOAzDBlyWhtn8whLmQ==
X-Google-Smtp-Source: ABdhPJyau3vwZizn5lszy0tnYyuMkUDpbu7kodaIOz+NuCXqeyAndag20YrceFIupyg5eTLtkLBv2peyr02ky84U29w=
X-Received: by 2002:a17:90a:6c47:: with SMTP id x65mr2499136pjj.8.1635992927436;
 Wed, 03 Nov 2021 19:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211018051251.2289112-1-vishal.l.verma@intel.com>
In-Reply-To: <20211018051251.2289112-1-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 3 Nov 2021 19:28:36 -0700
Message-ID: <CAPcyv4iYhbXsT8uJqQwPPXV4KPdh0CVEdzyuSocmtmwZcwr1-g@mail.gmail.com>
Subject: Re: [PATCH v3] tools/testing/cxl: add mock output for the
 GET_HEALTH_INFO command
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, Oct 17, 2021 at 10:13 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add mocked health information for cxl_test memdevs. This allows
> cxl-cli's 'list' command to display the canned health_info fields.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  tools/testing/cxl/test/mem.c | 48 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> Changes since v2[1]:
> - Fix cpu_to_leXX for 32bit fields (Jonathan)
> - Collect review tags

Apologies for the delay now applied, rebased on the cxl_dev_state rename.
