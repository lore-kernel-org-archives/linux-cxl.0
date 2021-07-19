Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839A4C07E9D
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Jul 2021 14:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5D2610D2
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Jul 2021 14:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhGSNj3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Jul 2021 09:39:29 -0400
Received: from mail.teo-en-ming-corp.com ([194.233.66.226]:43638 "EHLO
        mail.teo-en-ming-corp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhGSNj3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Jul 2021 09:39:29 -0400
Received: from mail.teo-en-ming-corp.com (mail.teo-en-ming-corp.com [127.0.0.1])
        by mail.teo-en-ming-corp.com (Postfix) with ESMTP id 4GT3gY47N6zk79y
        for <linux-cxl@vger.kernel.org>; Mon, 19 Jul 2021 22:11:53 +0800 (+08)
Authentication-Results: mail.teo-en-ming-corp.com (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=teo-en-ming-corp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        teo-en-ming-corp.com; h=content-transfer-encoding:content-type
        :organization:message-id:user-agent:reply-to:subject:to:from
        :date:mime-version; s=dkim; t=1626703912; x=1629295913; bh=hYHGw
        vDIp91Lia793OutrdhqvMRQY9N/nwUKfFIX7ZM=; b=cbt+CJjPuRzbpOary2i0L
        tHJKJVSX1IkzlC6LimEftYgo/A5fh+3+TJshlL1owd9ILnvxZCZ1ol+ZxFL/Rj1C
        hF1sDFh1SIujqvQk6CdNKhSDsI1tTXYqU0+IPa3PRxpFxNidjD491/Vao4u0RZry
        hcVbFvMkGl9i/DcbW36u6PhPtEAw+XAg/lPUSxX6mqffM7pu5UKu7S80G7rujGfM
        92RinpduRlPsNusNq4FOO8qt++pcRxmR47Cj6JD/f2jE0uovmsmAy56iA+7RB/n+
        rTnQxDO7qBfnEWKCoKnO+n/Cow7qHwMRMzEH8mdtVmwdPbYCb1PMFZq8vbF6cWpI
        Q==
X-Virus-Scanned: Debian amavisd-new at vmi576090.contaboserver.net
Received: from mail.teo-en-ming-corp.com ([127.0.0.1])
        by mail.teo-en-ming-corp.com (mail.teo-en-ming-corp.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Fdrdb97Jt0Gl for <linux-cxl@vger.kernel.org>;
        Mon, 19 Jul 2021 22:11:52 +0800 (+08)
Received: from localhost (mail.teo-en-ming-corp.com [127.0.0.1])
        by mail.teo-en-ming-corp.com (Postfix) with ESMTPSA id 4GT3gX4KFgzkQ8M
        for <linux-cxl@vger.kernel.org>; Mon, 19 Jul 2021 22:11:52 +0800 (+08)
MIME-Version: 1.0
Date:   Mon, 19 Jul 2021 22:11:52 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-cxl@vger.kernel.org
Subject: Introduction: I am a Linux and open source software enthusiast
Reply-To: ceo@teo-en-ming-corp.com
User-Agent: Roundcube Webmail
Message-ID: <a790652b5e88e5932ae1ed7064d0f819@teo-en-ming-corp.com>
X-Sender: ceo@teo-en-ming-corp.com
Organization: Teo En Ming Corporation
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Subject: Introduction: I am a Linux and open source software enthusiast

Greetings from Singapore,

My name is Mr. Turritopsis Dohrnii Teo En Ming. 43 years old as of 19 
July 2021. I live in Singapore. I am an IT Consultant with a System 
Integrator (SI)/computer firm in Singapore. I am a Linux and open source 
software and information technology enthusiast.

You can read my "Autobiography of Singaporean Targeted Individual Mr. 
Turritopsis Dohrnii Teo En Ming (Very First Draft, Lots More to Add in 
Future)" on my redundant blogs. Links to my redundant blogs can be found 
in my email signature below.

I have three other redundant blogs, namely:

https://teo-en-ming.tumblr.com/

https://teo-en-ming.medium.com/

https://teo-en-ming.livejournal.com/

Future/subsequent drafts of my Autobiography will be published on my 
redundant blogs.

Thank you very much.




-- 
-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's
Academic Qualifications as at 14 Feb 2019 and refugee seeking attempts
at the United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan
(5 Aug 2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
