Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A8BC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Jan 2022 22:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiANWsJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Jan 2022 17:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiANWsI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Jan 2022 17:48:08 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDC7C061574
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jan 2022 14:48:08 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id h23so3887077pgk.11
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jan 2022 14:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bbh9yc9OnBBCsyNMtewRPFcwLMZ/zT5pAXTX2uqKp6E=;
        b=2N+gAi8Eyyh1OYsmYzS19flf1xIZVuXNWRXKUWtSsyBPHqYXEQPZjtRYH348ipQWX0
         NjJ7hJ2lNyRD4uOHtcaNTC5IAF3nE1S/lpFYgLh3SjWs8dflIY902u6QnAdBmPOK3KV8
         aIr3unGhDFyDcRsggHttaP2K8w2VbeJiAMAfdCHT9zn9NIf4HJx5dXM58zGGZDNIpyX8
         IzD7Efy28lhIhCy1lwbXkxrmAJ0kst1MONnB9Qzg9nUnFW4YD9j8hHxdo1za6t8CI97O
         gAGPCxzGMe3Ek7g7lBUijiUvdDfHwzZ2AvRpy3PKq7ETCw0Nq4F1Y8iWzBi+ly/FjPNP
         ia6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bbh9yc9OnBBCsyNMtewRPFcwLMZ/zT5pAXTX2uqKp6E=;
        b=t6rio4EM3WpNABjNwf2fRJyMaUyez2/ysw9aAl8r4exq5Ezuxd9zMph/E5jICN9euM
         fB/2RDSmGPTqmOY7CKdVud6i/gmafsBluJfJ+IFveZjjhtUaDx2IN0PebtSs1g2YAIin
         wOVQXogGApbFTx9bVqJKQUTltPEGhEM3/aXsWmPDkdrS0QMY2VSTqJ6kEX92Hj690ZNL
         y15YX5+1Ocox+FRPiD/mDNNrJYb94OroSsZMhjk/7zi5NgaFNqvYASUy96HX/zjr9zyE
         sDC/ZsmBjxmsyh/B7P3w/hXA0355sxQONGq8h7zaq8cUhTngYevy4GlemG0TR9UEP8du
         WO1A==
X-Gm-Message-State: AOAM532SyS+AkYpMHyOSLezrRHSa+auVjot/WAJrZDdEVBB29044AyHM
        AsvSkxgRk9dF/bgeg4YlssdB6Mf/FYbC9TfcLYWiDQ==
X-Google-Smtp-Source: ABdhPJzPoZIBuoaUUI00ZUgK3B/CfFrD05XFj73lA9ZdsIu63rDQP1HReFNdEbHGBljecLAhVrof9ZtUfYvFkSU4DDs=
X-Received: by 2002:a63:79c2:: with SMTP id u185mr9995735pgc.74.1642200487958;
 Fri, 14 Jan 2022 14:48:07 -0800 (PST)
MIME-Version: 1.0
References: <164141829899.3990253.17547886681174580434.stgit@dwillia2-desk3.amr.corp.intel.com>
 <d4a57facb2b778867e3bbe8564f03868b58e2f72.camel@intel.com> <c6be7804-419e-d547-062d-6b852494bceb@oracle.com>
In-Reply-To: <c6be7804-419e-d547-062d-6b852494bceb@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 14 Jan 2022 14:47:55 -0800
Message-ID: <CAPcyv4jYg3DRv6Eeq3s2c0kk4dSvr3_i_jk+Uc2Pew9FON+zmA@mail.gmail.com>
Subject: Re: [ndctl PATCH v3 00/16] ndctl: Meson support
To:     Jane Chu <jane.chu@oracle.com>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "breno.leitao@gmail.com" <breno.leitao@gmail.com>,
        "vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>,
        "kilobyte@angband.pl" <kilobyte@angband.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 14, 2022 at 2:31 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> Hi,
>
> Should the README.md file get updated accordingly?

Indeed! Will fix.
