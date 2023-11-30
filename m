Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A863F10CE
	for <linux-cxl@vger.kernel.org>; Wed, 29 Nov 2023 22:15:21 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee665682875151-429da;
	Thu, 30 Nov 2023 14:15:17 +0800 (CST)
X-RM-TRANSID:2ee665682875151-429da
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from smtpclient.apple (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee965682874d4f-76904;
	Thu, 30 Nov 2023 14:15:17 +0800 (CST)
X-RM-TRANSID:2ee965682874d4f-76904
From: lihuawei <lihuawei@cmss.chinamobile.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: cxl type3 mem device over Ethernet
Message-Id: <149A1DCD-BD15-4CEB-A509-D7F2FBBF0D83@cmss.chinamobile.com>
Date: Thu, 30 Nov 2023 14:15:06 +0800
To: linux-cxl@vger.kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)

Hi everyone,

we recently research and want to implement cxl type3 mem device over =
Ethernet(like Roce, IB over Eth). But encounter some challenging =
problems as:

1. Does it technically possible?
2. To achieve this goal, what should we have to acquire about cxl? Too =
much new knowledge to our team about cxl/pcie/mem and so on, but our =
team is proficient about cloud network and SDN.
3. Can anyone offer some help? Any ideas and advices are welcome.

Sincerely.=


